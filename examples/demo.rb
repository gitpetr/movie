require 'csv' 
require 'ostruct'
require 'date'
TITRES = %i[link name  year country date  genre duratation rating director actors]
require_relative '../app/movie_collection'
require_relative '../app/movie'
require_relative '../app/ancientmovie'
require_relative '../app/classicmovie'
require_relative '../app/modernmovie'
require_relative '../app/newmovie'
require_relative '../app/netflix/netflix'
require_relative '../app/theatre/theatre'

MANTH = %i[Январь Февраль Март Апрель Май Июнь Июль Август Сентябрь Октябрь Ноябрь Декабрь]

@films = ARGV[0] || File.expand_path("../../app/movies.txt", __FILE__)
listfilms =  MovieCollection.new(@films)

puts "\t - Список всех фильмов(listfilms.all)"
listfilms.all.first(2).each{|f| puts f }
puts
puts "\t - Список фильмов.(listfilms.sortby(:year)) Показаны названия первых пяти "
listfilms.sortby(:year).first(5).each{|f| puts f } 
puts
puts "\t - Список актеров ( [6] )"
print "\t ", listfilms.actors[6]  
puts
puts
puts "\t - Cтатистика режиссёров:"
listfilms.stats(:director).sort.first(5).each{|k, v| listfilms.print_stats(k, v) }
puts
puts "\t - Cтатистика актеров:"
listfilms.stats(:actors).sort.first(5).each{|k, v| listfilms.print_stats(k, v) }
puts
puts "\t - Cтатистика по годам"
listfilms.stats(:year).first(5).each{|k, v|  listfilms.print_stats(k, v)  }
puts
puts "\t - Статистика по месяцам"
listfilms.stats(:month).each{|k, v| listfilms.print_stats(MANTH[k.to_i-1], v) }
puts
begin
puts("\t - Жанр фильма?")  
puts "\t listfilms.all.first.has_genre? 'Comedy' "
puts (listfilms.all.first.has_genre? 'Comedy')?  ("\t Yes") :  ("\t No")
puts "\t listfilms.all[154].has_genre? 'Comedy'"
puts (listfilms.all[154].has_genre? 'Comedy')?  "\t Yes" : "\t No"
puts "\t listfilms.all.first.has_genre? 'Drama'"
puts (listfilms.all.first.has_genre? 'Drama')?  "\t Yes" : "\t No"
puts "\t listfilms.all[3].has_genre? 'Drama'"
puts (listfilms.all[3].has_genre? 'Drama')?  "\t Yes" : "\t No"
puts "\t Если ошиблись с жанром listfilms.all[3].has_genre? 'Boevik'"
puts (listfilms.all[3].has_genre? 'Boevik')?  "\t Yes" : "\t No"
rescue RuntimeError => e 
  puts "\t\t #{e.message}"
end
puts
puts "\t - Список жанров"
puts listfilms.genries
puts
puts "\t - Фильтр: listfilms.filter( year: (1945..2010), genre: /Sci-Fi|Comedy|Romance|Drama/, director: /Zemeckis Robert|Cameron James/ )"
listfilms.filter( year: (1945..2010), genre: /Sci-Fi|Comedy|Romance|Drama/, actors: /Johansson|Elizabeth|Julie Delpy/ ).first(5).each{ |f| puts f }
puts 
netflix = Netflix.new(@films)
puts "netflix.show"

puts 
puts
netflix.pay(10)
begin
netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :modern)  
netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic)
netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :new) 
netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :ancient) 
netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic) 
netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic) 
netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :new) 
netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :new)  
netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :modern)  
netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic)
netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :new) 
netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :ancient) 
netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic) 
netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic) 
netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :new) 
netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :new)  
rescue RuntimeError => e 
  puts "\t\t #{e.message}"
end
puts 
netflix.pay(6)
begin
netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic) 
netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic) 
netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :new)
netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic) 
netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic) 
netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :new) 
netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :new) 
rescue RuntimeError => e 
  puts "\t\t #{e.message}" 
end
netflix.pay(1.3)
puts "netflix.how_much?" 
netflix.how_much?("Gone Girl")
netflix.how_much?("Double Indemnity")
netflix.how_much?("Persona") 
netflix.how_much?("Up") 
netflix.how_much?("The Great Escape")
puts 
puts  
theatre = Theatre.new(@films)
puts "theatre.show(13)"
theatre.show(13).first(4).each{ |f| puts "\t #{f}" }
puts ".........." 
theatre.when? "Double Indemnity"
theatre.when? "The Prestige"
theatre.when? "Who's Afraid of Virginia Woolf?"
theatre.when? "Once Upon a Time in America"
theatre.when? "One Flew Over the Cuckoo's Nest"
theatre.when? "The Lord of the Rings: The Return of the King"