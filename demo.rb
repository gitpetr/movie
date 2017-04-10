require 'csv' 
require 'ostruct'
require 'date'
require_relative 'movie_collection'
TITRES = %i[link name  year country date  genre duratation rating director actors]
require_relative 'movie'
MANTH = %i[Январь Февраль Март Апрель Май Июнь Июль Август Сентябрь Октябрь Ноябрь Декабрь]

@films = ARGV[0] || "./movies.txt"
listfilms =  MovieCollection.new(@films)

puts "\t - Список всех фильмов(listfilms.all)"
listfilms.all.first(5).each{|f| f.to_s }
puts
puts "\t - Список фильмов.(listfilms.sortby(:year)) Показаны названия первых пяти "
listfilms.sortby(:year).first(5).each{|f| f.to_s } 
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
listfilms.stats(:month).each{|k, v| listfilms.print_stats(MANTH[k.to_i-1].to_s, v) }
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
rescue Exception => e 
  puts "\t\t #{e.message}"
end
puts
puts "\t - Список жанров"
puts listfilms.genries
puts
puts "\t - Фильтр: listfilms.filter( year: (1945..2010), genre: /Sci-Fi|Comedy/, director: /Zemeckis Robert|Cameron James/ )"
listfilms.filter( year: (1945..2010), genre: /Sci-Fi|Comedy|Romance|Drama/, actors: /Johansson|Elizabeth|Julie Delpy/ ).first(5).each{ |f| f.to_s }
 