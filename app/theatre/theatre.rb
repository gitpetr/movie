class Theatre < MovieCollection
  MORNING = (9..13)
  DAY = (14..18) 
  EVENING = (19..24) 
  MORNING_SEANS = PERIODS[:ancient]
  DAY_SEANS = /Adventure|Comedy/
  EVENING_SEANS = /Drama|Horror/
  FILTERDAY = { genre: DAY_SEANS }
  FILTEREVENING = { genre: EVENING_SEANS }
  FILTERMORNING =  { year: PERIODS[:ancient]  }

  def show(filters)
    if  MORNING === filters 
      filter(FILTERMORNING).each{ |f| f.description }
    elsif DAY === filters
      filter(FILTERDAY).each{ |f| f.description }
    elsif EVENING === filters
      filter(FILTEREVENING).each{ |f| f.description }
    else 
     ["В указанное время сеансов нет \n"]
    end
  end

  def when? filmname
    filter(name: filmname).each do |f|
      if MORNING_SEANS === f.year
        puts "Сеансы фильма: #{ f.description } идут  c #{ MORNING.first } по #{ MORNING.last } " 
      elsif  DAY_SEANS === f.genre.to_s
        puts "Сеансы фильма: #{ f.description } идут с #{ DAY.first } по #{ DAY.last } "
      elsif EVENING_SEANS === f.genre.to_s 
        puts "Сеансы фильма: #{ f.description } идут с #{ EVENING.first } по #{ EVENING.last } "
      else
        puts "Такого сеанса в настоящее время нет"
      end
    end
  end
end
