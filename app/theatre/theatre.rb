class Theatre < MovieCollection
  Morning = (9..13)
  Day = (14..18) 
  Evening = (19..24) 

  Day_seans = /Adventure|Comedy/
  Evening_seans = /Drama|Horror/

  FilterDey = { genre: Day_seans }
  FilterEvening = { genre: Evening_seans }
  # FilterMorning = { year: @period[:ancient] }
  def show(filters)
    if  Morning === filters 
      filter(year: period[:ancient]).each{ |f| f.description }
    elsif Day === filters
      filter(FilterDey).each{ |f| f.description }
    elsif Evening === filters
      filter(FilterEvening).each{ |f| f.description }
    else 
     ["В указанное время сеансов нет \n"]
    end
    
  end

  def when? filmname
    filter(name: filmname).each do |f|

      if period[:ancient] === f.year
        puts "Сеансы фильма: #{ f.description } идут  c #{ Morning.first } по #{ Morning.last } " 
      elsif  (Day_seans === f.genre.to_s) 
        puts "Сеансы фильма: #{ f.description } идут с #{ Day.first } по #{ Day.last } "
      elsif (Evening_seans === f.genre.to_s) 
        puts "Сеансы фильма: #{ f.description } идут с #{ Evening.first } по #{ Evening.last } "
      else
        puts "Такого сеанса в настоящее время нет"
      end
    end
  end
end
