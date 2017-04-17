class AncientMovie < Movie
  
  def cost
    1 
  end 

  def description
   " #{ @name } - старый фильм ( #{ @year }, - #{ @duratation }). "
  end

  def watch
    @collection.payment(cost) 
    "Оплата просмотра фильма 1 доллар на счете осталось $#{@collection.deposit}"
  end

end
