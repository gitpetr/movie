require 'rspec'
require 'csv' 
require_relative '../movie_collection'
TITRES = %i[link name  year country date  genre duratation rating director actors]
require_relative '../movie'
MANTH = %i[Январь Февраль Март Апрель Май Июнь Июль Август Сентябрь Октябрь Ноябрь Декабрь]

@films = ARGV[0] || "../movies.txt"

RSpec.describe MovieCollection  do 
  listfilms =  MovieCollection.new("../movies.txt")
  describe 'Показать список всех фильмов' do 
    it "return count films" do
      @allfilms = CSV.read("../movies.txt", col_sep: '|', headers: TITRES ).map{ |f| Movie.new(self, f.to_h) }
      expect( @allfilms.count).to eq 250
    end
  end
  
  describe "Сортировка по полю" do 
    it 'listfilms.sortby(:year).first' do 
      film = listfilms.sortby(:year).first
      expect(film.year ).to eq 1921
    end
  end

  describe "actors" do 
    it "in firs film" do 
      film = listfilms.actors.first
      expect(film).to match_array(["Bob Gunton", "Morgan Freeman", "Tim Robbins"])
    end
  end

  describe 'статистика' do 
    it 'режиссеров' do 
      director = listfilms.stats(:director).sort.first(1).each{|k, v| listfilms.print_stats(k, v) }
      expect(director).to match a_hash_including ["Allen Woody", 1]
    end
  end

  describe 'Фильтр по параметрам' do 
    it "years, genre, acters" do 
       filtr = listfilms.filter( year: (1945..2010), genre: /Sci-Fi|Comedy|Romance|Drama/, actors: /Johansson|Elizabeth|Julie Delpy/ ).first(5).each{ |f| f.to_s }
       expect(filtr[0].director).to  eq "Nolan Christopher"
    end
  end
end
