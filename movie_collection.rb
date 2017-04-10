class MovieCollection 
  
  attr_reader :allfilms, :genries
  
  def initialize filmfile
    unless File.exist?(filmfile)  
      abort " Такого файла не существует"
    end
    @allfilms = CSV.read(filmfile, col_sep: '|', headers: TITRES ).map{ |f| Movie.new(self, f.to_h) }
    @genries = genres
  end

  def all
     @allfilms
  end

  def sortby (name)
    @allfilms.sort_by(&name) 
  end

  def actors
    @allfilms.map { |f|  f.actors }
  end

  def stats(field)
    @allfilms.flat_map(&field).compact.sort.inject(Hash.new(0)){ |h, e| h[e]+=1; h }  
  end

  def print_stats k, v
    puts "\t#{k.to_s.ljust(15)} #{v}"
  end

  def genres
    @genries = all.flat_map(&:genre).uniq.sort
  end

  def filter(filters) 
    @allfilms.select{ |f| f.match_filter?(filters) } 
  end
  
end
