class MovieCollection 
  
  attr_reader :allfilms, :genries
  
  def initialize filmfile
    unless File.exist?(filmfile)  
      abort " Такого файла не существует"
    end
    #@allfilms = CSV.read(filmfile, col_sep: '|', headers: TITRES ).map{ |f| Movie.new(self, f.to_h) }
    @allfilms  = CSV.read(filmfile, col_sep: '|', headers: TITRES ).map{ |f| create(:year) }
    @genries = genres
  end

  def create year
    case year
    when (1900..1945) then 
      AncientMovie.new(self, f.to_h)
    when (1945..1968) then 
      ClassicMovie.new(self, f.to_h)
    when (1968..2000) then 
      ModernMovie.new(self, f.to_h)
    when (2000..Time.now.year) then 
      NewMovie.new(self, f.to_h)
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

  def period
    {  ancient: (1900..1945), classic: (1945..1968), modern: (1968..2000), new: (2000..Time.now.year) }
  end

  def typofperiod period
    director = 'неизвестный'
    case period
    when :ancient then 
      "старый фильм"
    when :classic then 
      "классический фильм"
    when :modern then 
      "современное кино"
    when :new then 
      "новинка"
    end
  end
   
end
