class MovieCollection 
  
  attr_reader :allfilms, :genries

  def period 
    {ancient: 1900..1945, classic: 1946..1968, modern: 1969..2000, new: 2001..Time.now.year}
  end
  
  def initialize filmfile
    unless File.exist?(filmfile)  
      abort " Такого файла не существует"
    end
    @allfilms = CSV.read(filmfile, col_sep: '|', headers: TITRES )
      .map{ |f| class_for(f.to_h[:year].to_i).new(self, f.to_h) }
      .sort_by{|f| f.rating * rand(3) }.reverse

    @genries = genres
  end

  def class_for year
    case year
    when period[:ancient] 
      AncientMovie 
    when period[:classic] 
      ClassicMovie 
    when period[:modern]
      ModernMovie 
    when period[:new]
      NewMovie 
    end
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
