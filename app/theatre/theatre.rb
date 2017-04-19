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
  TIMES = {
    morning: MORNING,
    day: DAY,
    evening: EVENING
  }

  FILTRES = {
    morning: FILTERMORNING,
    day: FILTERDAY,
    evening: FILTEREVENING  
  }

  def show(filters)
    if (9..24) === filters 
      filter(FILTRES[TIMES.map{ |k, v| k if  v === filters }.compact[0]]).each{ |f| f.description } 
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
