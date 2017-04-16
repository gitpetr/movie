class Theatre < MovieCollection

  attr_reader :morning, :day, :evening
  Morning = ' с 9 до 13 часов '
  Day = ' с 14 до 18 часов ' 
  Evening = ' с 19 до 24 часов ' 

  # def time 
  #   { morning:  }
  # end

  def show(filters)

    if  (9..13) === filters 
      filter(year: 1900..1945).each{|f| f.film}
    elsif (14..18) === filters
      filter(genre: /Adventure|Comedy/).each{|f| f.film}
    elsif (19..24) === filters
       filter(genre: /Drama|Horror/).each{|f| f.film}
    else 
     ["В указанное время сеансов нет \n"]
    end
    
  end

  def when? filmname
    filter(name: filmname).each do |f|

      if (1900..1945) === f.year
        puts "Сеансы фильма: #{f.film} идут #{Morning} " 
      elsif  (/Adventure|Comedy/ === f.genre.to_s) 
        puts "Сеансы фильма: #{f.film} идут #{Day} "
      elsif (/Drama|Horror/ === f.genre.to_s) 
        puts "Сеансы фильма: #{f.film} идут #{Evening} "
      else
        puts "Такого сеанса в настоящее время нет"
      end

    end
      
  end

end
