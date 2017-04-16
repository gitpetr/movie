class  ModernMovie < Movie

  def cost
    2 
  end 

  def film
    str = "\t #{ @name } - современное кино ( #{ @year }, - #{ @duratation }). Играют "
    str += @actors.join(', ')
    str += "\n\n"
  end

  def watch
    @collection.payment(cost) 
    puts "Оплата просмотра фильма 2 доллара, на счете осталось $#{@collection.deposit}"
  end

end
