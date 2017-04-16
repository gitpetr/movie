class NewMovie < Movie
  def cost
    2.5 
  end 
   
  def film
    puts @collection
    "\t #{ @name } - новинка вышло #{ Time.now.year - @year } лет назад. ( #{ @year }, - #{ @duratation }). \n\b"
  end

  def watch
    @collection.payment(cost) 
    puts "Оплата просмотра фильма 2,5 доллара на счете осталось $#{@collection.deposit}"
  end

end
