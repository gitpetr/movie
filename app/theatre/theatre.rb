class Theatre < MovieCollection
 
  Morning = (9..13)
  Day = (14..18) 
  Evening = (19..24) 

  def day_seans
    /Adventure|Comedy/
  end

  def evening_seans 
    /Drama|Horror/
  end
 
  def show(filters)

    if  Morning === filters 
      filter(year: period[:ancient]).each{ |f| f.description }
    elsif Day === filters
      filter(genre: day_seans).each{ |f| f.description }
    elsif Evening === filters
       filter(genre: evening_seans).each{ |f| f.description }
    else 
     ["В указанное время сеансов нет \n"]
    end
    
  end

  def when? filmname
    filter(name: filmname).each do |f|

      if period[:ancient] === f.year
        puts "Сеансы фильма: #{ f.description } идут  c #{ Morning.first } по #{ Morning.last } " 
      elsif  (day_seans === f.genre.to_s) 
        puts "Сеансы фильма: #{ f.description } идут с #{ Day.first } по #{ Day.last } "
      elsif (evening_seans === f.genre.to_s) 
        puts "Сеансы фильма: #{ f.description } идут с #{ Evening.first } по #{ Evening.last } "
      else
        puts "Такого сеанса в настоящее время нет"
      end
    end
  end
end
