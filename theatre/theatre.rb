class Theatre < MovieCollection
 
  def show(filters)

    if  (9..13) === filters 
      filter(year: 1900..1945).each{|f| f.film.to_s}
    elsif (14..18) === filters
      filter(genre: /Adventure|Comedy/).each{|f| f.film.to_s}
    elsif (19..24) === filters
       filter(genre: /Drama|Horror/).each{|f| f.film.to_s}
    else 
     ["В указанное время сеансов нет \n"]
    end
    
  end

end