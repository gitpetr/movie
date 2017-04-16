class  ModernMovie < Movie

  def cost
    2 
  end 

  def film
    str = " #{ @name } - современное кино ( #{ @year }, - #{ @duratation }). Играют "
    str += @actors.join(', ')
    str += "."
  end

  def watch
    @collection.payment(cost) 
    "Оплата просмотра фильма 2 доллара, на счете осталось $#{@collection.deposit}"
  end

end
