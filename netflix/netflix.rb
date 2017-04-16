# require '../movie_collection.rb'
class Netflix < MovieCollection
  attr_reader :deposit

  def period 
    {ancient: 1900..1945, classic: 1945..1968, modern: 1968..2000, new: 2000..Time.now.year}
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
      filters[:year] =  period[filters[:period]]
      period = filters[:period]
      filters.delete(:period)
    end
    
    filter(filters).each{|f| print f.film}

  end

  def watch(film)
    filter(name: film).each{ |f| print f.film; f.watch }
  end

  def how_much?(film)
    filter(name: film).each{ |f| puts "просмотр фильма стоит $#{f.cost}, на вашем счете   $#{@deposit}" }
  end

end
