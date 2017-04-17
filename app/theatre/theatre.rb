class Theatre < MovieCollection

  attr_reader :morning, :day, :evening
  Morning = (9..13)
  Day = (14..18) 
  Evening = (19..24) 
 
  def show(filters)

    if  Morning === filters 
      filter(year: 1900..1945).each{ |f| f.description }
    elsif Day === filters
      filter(genre: /Adventure|Comedy/).each{ |f| f.description }
    elsif Evening === filters
       filter(genre: /Drama|Horror/).each{ |f| f.description }
    else 
     ["В указанное время сеансов нет \n"]
    end
    
  end

  def when? filmname
    filter(name: filmname).each do |f|

      if period[:ancient] === f.year
        puts "Сеансы фильма: #{ f.description } идут  c #{ Morning.first } по #{ Morning.last } " 
      elsif  (/Adventure|Comedy/ === f.genre.to_s) 
        puts "Сеансы фильма: #{ f.description } идут с #{ Day.first } по #{ Day.last } "
      elsif (/Drama|Horror/ === f.genre.to_s) 
        puts "Сеансы фильма: #{ f.description } идут с #{ Evening.first } по #{ Evening.last } "
      else
        puts "Такого сеанса в настоящее время нет"
      end

    end
      
  end

end
