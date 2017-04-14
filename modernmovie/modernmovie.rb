class  ModernMovie < Movie
  #
end
def create year


require_relative './ancientmovie/ancientmovie'
require_relative './classicmovie/classicmovie'
require_relative './modernmovie/modernmovie'
require_relative './newmovie/newmovie'

  
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