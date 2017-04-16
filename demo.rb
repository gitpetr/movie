require 'csv' 
require 'ostruct'
require 'date'
TITRES = %i[link name  year country date  genre duratation rating director actors]
require_relative 'movie_collection'
require_relative 'movie'
require_relative 'ancientmovie'
require_relative 'classicmovie'
require_relative 'modernmovie'
require_relative 'newmovie'
require_relative 'netflix/netflix'
require_relative 'theatre/theatre'

MANTH = %i[Январь Февраль Март Апрель Май Июнь Июль Август Сентябрь Октябрь Ноябрь Декабрь]

@films = ARGV[0] || "./movies.txt"
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
netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic) 
puts 
puts
netflix.pay(10)
begin
netflix.watch(/The Prestige/) 
netflix.watch(/Once Upon a Time in America/) 
netflix.watch(/Who's Afraid of Virginia Woolf?/) 
netflix.watch(/Double Indemnity/) 
netflix.watch(/Double Indemnity/) 
netflix.watch(/Double Indemnity/) 
netflix.watch(/Double Indemnity/) 
netflix.watch(/Double Indemnity/) 
netflix.watch(/Double Indemnity/) 
netflix.watch(/Double Indemnity/) 
netflix.watch(/Double Indemnity/) 
netflix.watch(/Double Indemnity/) 
netflix.watch(/Double Indemnity/) 
netflix.watch(/Double Indemnity/)
rescue RuntimeError => e 
  puts "\t\t #{e.message}"
end
puts 
netflix.pay(1)
begin
puts "netflix.how_much?('Double Indemnity')"
netflix.how_much?(/Double Indemnity/)
netflix.watch("Double Indemnity")
puts "netflix.how_much?('Double Indemnity')" 
netflix.how_much?("Double Indemnity")
rescue RuntimeError => e 
  puts "\t\t #{e.message}" 
end
puts 
puts  
theatre = Theatre.new(@films)
puts "theatre.show(10)"
theatre.show(13).first(4).each{ |f| puts "\t #{f}" }
puts ".........." 
theatre.when? "Double Indemnity"
theatre.when? "The Prestige"
theatre.when? "Who's Afraid of Virginia Woolf?"
theatre.when? "Once Upon a Time in America"
