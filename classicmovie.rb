class ClassicMovie < Movie

  def cost
    1.5 
  end 

  def film
    str = "\t #{ @name } - классический фильм ( #{ @year }, - #{ @duratation }). Режиссер #{@director}, "
    str +=  "\n\t\t\t Его картины: \n\t"
    str += @collection.filter( director: @director ).join("\t ")
    str += "\n\n"
   end

   def watch
    @collection.payment(cost) 
    puts "Оплата просмотра фильма 1,5 доллар на счете осталось $#{@collection.deposit}"
   end

end
