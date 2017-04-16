class NewMovie < Movie
  def cost
    2.5 
  end 
   
  def film
    " #{ @name } - новинка вышло #{ Time.now.year - @year } лет назад. ( #{ @year }, - #{ @duratation }). "
  end

  def watch
    @collection.payment(cost) 
    "Оплата просмотра фильма 2,5 доллара на счете осталось $#{@collection.deposit}"
  end

end
