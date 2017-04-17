class  ModernMovie < Movie

  def cost
    2 
  end 

  def description
    format(" %s - современное кино ( %s, - %s). Играют %s .",  @name, @year, @duratation, @actors.join(', '))
  end

  def watch
    @collection.payment(cost) 
    "Оплата просмотра фильма 2 доллара, на счете осталось $#{@collection.deposit}"
  end

end
