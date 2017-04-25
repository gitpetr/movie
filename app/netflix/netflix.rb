class Netflix < MovieCollection
  attr_reader :deposit
  
  def initialize filmfile
    super
    @deposit = 0
  end

  def pay(deposit)
     @deposit += deposit
     self.class.depo deposit
  end

  def payment(cost)
    raise "Извините! У вас недостаточно средств на счете" unless  (@deposit-cost) >= 0
    @deposit-=cost
  end 

  def show(filters)
    if filters[:period]
      filters[:year] = PERIODS[filters[:period]]
      filters.delete(:period)
    end
    filter(filters).sort_by{ |f|  f.rating.to_i * rand(10) }.reverse.first(1).each{|f| puts " Фильм: #{ f.description } #{ f.watch } " }
  end

  def how_much?(film)
    filter(name: film).each{ |f| print "#{ f.description } - просмотр фильма стоит $#{ f.cost }, на вашем счете   $#{ @deposit } \n" }
  end
end
