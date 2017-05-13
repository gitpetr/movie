require 'csv'
require 'ostruct'
require 'date'
require_relative '../app/cashbox'
require_relative '../app/movie_collection'
require_relative '../app/movie'
require_relative '../app/ancientmovie'
require_relative '../app/classicmovie'
require_relative '../app/modernmovie'
require_relative '../app/newmovie'
require_relative '../app/netflix/netflix'
require_relative '../app/theatre/theatre'

MANTH = %i[Январь Февраль Март Апрель Май Июнь Июль Август Сентябрь Октябрь Ноябрь Декабрь].freeze

@films = ARGV[0] || File.expand_path('../../app/movies.txt', __FILE__)
listfilms = Cinema::MovieCollection.new(@films)

puts "\t - Список всех фильмов(listfilms.all)"
listfilms.all.first(2).each { |f| puts f }
puts
puts "\t - Список фильмов.(listfilms.sortby(:year)) Показаны названия первых пяти "
listfilms.sortby(:year).first(5).each { |f| puts f }
puts
puts "\t - Список актеров [6] "
print "\t ", listfilms.actors[6]
puts
puts
puts "\t - Cтатистика режиссёров:"
puts listfilms.print_stat(:director).first(5)
puts
puts "\t - Cтатистика актеров:"
puts listfilms.print_stat(:actors).first(5)
puts
puts "\t - Cтатистика по годам"
puts listfilms.print_stat(:year).first(5)
puts
puts "\t - Статистика по месяцам"
puts listfilms.print_stat(:month).sort_by { |month| month[0..1].to_i }.map{ |month| format("%s%s", MANTH[month[0..1].to_i - 1], month[2..-1]) }
puts
begin
  puts("\t - Жанр фильма?")
  puts "\t listfilms.all.first.has_genre? 'Comedy' "
  puts listfilms.all.first.has_genre?('Comedy') ? "\t Yes" : "\t No"
  puts "\t listfilms.all[154].has_genre? 'Comedy'"
  puts listfilms.all[154].has_genre?('Comedy') ? "\t Yes" : "\t No"
  puts "\t listfilms.all.first.has_genre? 'Drama'"
  puts listfilms.all.first.has_genre?('Drama') ? "\t Yes" : "\t No"
  puts "\t listfilms.all[3].has_genre? 'Drama'"
  puts listfilms.all[3].has_genre?('Drama') ? "\t Yes" : "\t No"
  puts "\t Если ошиблись с жанром listfilms.all[3].has_genre? 'Boevik'"
  puts listfilms.all[3].has_genre?('Boevik') ? "\t Yes" : "\t No"
rescue RuntimeError => e
  puts "\t\t #{e.message}"
end
puts
puts "\t - Список жанров"
puts listfilms.genries
puts
puts "\t - Фильтр: listfilms.filter( year: (1945..2010), genre: /Sci-Fi|Comedy|Romance|Drama/, director: /Zemeckis Robert|Cameron James/ )"
listfilms.filter(year: (1945..2010), genre: /Sci-Fi|Comedy|Romance|Drama/, actors: /Johansson|Elizabeth|Julie Delpy/).first(5).each { |f| puts f }
puts
netflix = Cinema::Netflix.new(@films)
puts 'Netflix.new'
netflix.pay(30)
puts 'Netflix.show'
begin
puts netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/) { |movie|
                                     movie.name.include?('Terminator') &&
                                     movie.year > 1945 }
puts
puts
puts netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic)
puts netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :new)
puts netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :ancient)
puts netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic)
puts netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :ancient)
puts netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic)
puts netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :new)
puts netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :new)
puts netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :modern)
puts netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic)
puts netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :new)
puts netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :ancient)
puts netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic)
puts netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic)
puts netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :new)
puts netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :new)
rescue RuntimeError => e
  puts "\t\t #{e.message}"
end
puts
netflix.pay(6)
begin
puts netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic)
puts netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic)
puts netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :new)
puts netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic)
puts netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :classic)
puts netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :new)
puts netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :new)
rescue RuntimeError => e
  puts "\t\t #{e.message}"
end
netflix.pay(1.3)
puts 'netflix.how_much?'
puts netflix.how_much?('Gone Girl')
puts netflix.how_much?('Double Indemnity')
puts netflix.how_much?('Persona')
puts netflix.how_much?('Up')
puts netflix.how_much?('The Great Escape')
puts
puts
theatre = Cinema::Theatre.new(@films)
begin
  puts 'theatre.show(13)'
  puts theatre.show(13).sort_by { |f| f.rating.to_i * rand(20) }.reverse.first(4).inject(Array.new()) { |arr, f| arr << "\t #{f}" }
  puts 'theatre.show(22)'
  puts theatre.show(22).sort_by { |f| f.rating.to_i * rand(20) }.reverse.first(4).inject(Array.new()) { |arr, f| arr << "\t #{f}" }
  puts 'theatre.show(14)'
  puts theatre.show(14).sort_by { |f| f.rating.to_i * rand(20) }.reverse.first(4).inject(Array.new()) { |arr, f| arr << "\t #{f}" }
  puts 'theatre.show(2)'
  puts theatre.show(2).sort_by { |f| f.rating.to_i * rand(20) }.reverse.first(4).inject(Array.new()) { |arr, f| arr << "\t #{f}" }
rescue RuntimeError => e
  puts "\t\t #{e.message}"
end
puts 'theatre.when?'
puts theatre.when? 'Double Indemnity'
puts theatre.when? 'The Prestige'
puts theatre.when? "Who's Afraid of Virginia Woolf?"
puts theatre.when? 'Once Upon a Time in America'
puts theatre.when? "One Flew Over the Cuckoo's Nest"
puts theatre.when? 'The Lord of the Rings: The Return of the King'
puts 'theatre.cash'
puts theatre.cash
puts 'theatre.buy_ticket'
puts theatre.buy_ticket 'Double Indemnity'
puts 'theatre.cash'
puts theatre.cash
puts theatre.buy_ticket 'The Prestige'
puts theatre.buy_ticket "Who's Afraid of Virginia Woolf?"
puts 'theatre.cash'
puts theatre.cash
puts theatre.buy_ticket 'Once Upon a Time in America'
puts 'theatre.cash'
puts theatre.cash
puts theatre.buy_ticket "One Flew Over the Cuckoo's Nest"
puts 'theatre.cash'
puts theatre.cash
puts theatre.buy_ticket 'The Lord of the Rings: The Return of the King'
puts 'theatre.cash'
puts  theatre.cash

begin
  puts theatre.take 'money'
rescue RuntimeError => e
  puts "\t\t #{e.message}"
end
puts theatre.cash
puts 'Netflix.cash'
puts Cinema::Netflix.cash
begin
  puts Cinema::Netflix.take 'money'
rescue RuntimeError => e
  puts "\t\t #{e.message}"
end
puts 'theatre.cash'
puts theatre.cash
puts 'Netflix.cash'
puts Cinema::Netflix.cash
begin
  puts theatre.take 'Bank'
rescue RuntimeError => e
  puts "\t\t #{e.message}"
end
puts theatre.cash
puts Cinema::Netflix.cash
begin
  puts Cinema::Netflix.take 'Bank'
rescue RuntimeError => e
  puts "\t\t #{e.message}"
end
puts 'theatre.cash'
puts theatre.cash
puts 'Netflix.cash'
puts Cinema::Netflix.cash
puts "###########"
puts
# begin
# netflix.define_filter(:my){ |f| p f }
# rescue RuntimeError => e
#     puts "#{e.message}"
# end

puts
netflix.pay(60)
netflix.define_filter(:new_sci_fi) { |film| film.genre.include?('Sci-Fi') && film.country != 'UK' }
netflix.define_filter(:new_fi) { |movie| !movie.title.include?('Terminator') && movie.genre.include?('Action') && movie.year > 2013 }


netflix.define_filter(:fi) { |movie|
                                     movie.name.include?('Terminator') &&
                                     movie.year > 1945 }
# puts
puts
# puts netflix.show(fi: true)

puts netflix.show(new_sci_fi: true)
puts netflix.show(new_fi: true)
