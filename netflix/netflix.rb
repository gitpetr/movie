class Netflix < MovieCollection
  attr_reader :deposit

  def period 
    {ancient: 1900..1945, classic: 1946..1968, modern: 1969..2000, new: 2001..Time.now.year}
  end

  def pay(deposit)
    if @deposit
      @deposit += deposit
    else
      @deposit = deposit
    end
  end

  def payment(cost)
    raise "Извините! У вас недостаточно средств на счете" unless  (@deposit-cost) >= 0
    @deposit-=cost
  end 
   
  def show(filters)

    if filters[:period]
      filters[:year] = period[filters[:period]]
      period = filters[:period]
      filters.delete(:period)
    end
    
    filter(filters).first(5).each{|f| puts f.film}

  end

  def watch(film)
    filter(name: film).each{ |f| puts " Фильм: #{f.film} #{f.watch} "}
  end

  def how_much?(film)
    filter(name: film).each{ |f| print "#{ f.film } - просмотр фильма стоит $#{ f.cost }, на вашем счете   $#{@deposit} \n" }
  end

end
