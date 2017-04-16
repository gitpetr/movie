class AncientMovie < Movie
  
  def cost
    1 
  end 

  def film
   "\t #{ @name } - старый фильм ( #{ @year }, - #{ @duratation }). \n\b"
  end

  def watch
    @collection.payment(cost) 
    "Оплата просмотра фильма 1 доллар на счете осталось $#{@collection.deposit}"
  end

end
