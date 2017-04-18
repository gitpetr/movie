require 'rspec'
require 'rspec/its'
require 'csv' 
require_relative '../app/movie_collection'
require_relative '../app/movie'
require_relative '../app/netflix/netflix'
require_relative '../app/ancientmovie'
require_relative '../app/classicmovie'
require_relative '../app/modernmovie'
require_relative '../app/newmovie'

RSpec.describe Netflix do
  let(:netflix) { Netflix.new(File.expand_path("../../app/movies.txt", __FILE__)) }
  before{ netflix.pay(18) }
  describe "#show" do
    subject {netflix.show( year: (1945..2010),
                                  genre: /Sci-Fi|Comedy|Romance|Drama/,
                                  actors: /Johansson|Elizabeth|Julie Delpy/ ) }
    it { is_expected.to have_attributes(:year => 2006,
                                          :genre => ["Drama", "Mystery", "Thriller"],
                                          :actors => ["Christian Bale", "Hugh Jackman", "Scarlett Johansson"]) }
  end
 
end
