class ClassicMovie < Movie

  def cost
    1.5 
  end 

  def film
    str = " #{ @name } - классический фильм ( #{ @year }, - #{ @duratation }). Режиссер #{@director}, "
    str +=  "\n\t\t\t Его картины: \n "
    str += @collection.filter( director: @director ).join("\n ")
    str += "\n "
   end

   def watch
    @collection.payment(cost) 
    " - Оплата просмотра фильма $1,5 на счете осталось $#{@collection.deposit} \n"
   end

end
