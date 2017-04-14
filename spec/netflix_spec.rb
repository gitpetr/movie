require 'rspec'
require 'rspec/its'
require 'csv' 
require_relative '../movie_collection'
TITRES = %i[link name  year country date  genre duratation rating director actors]
require_relative '../movie'
require_relative '../netflix/netflix'
RSpec.describe Netflix do
  let(:netflix) { Netflix.new("../movies.txt") }
  describe "#show" do
    subject {netflix.show( year: (1945..2010),
                                  genre: /Sci-Fi|Comedy|Romance|Drama/,
                                  actors: /Johansson|Elizabeth|Julie Delpy/ ).first }
    it { is_expected.to have_attributes(:year => 2006,
                                          :genre => ["Drama", "Mystery", "Thriller"],
                                          :actors => ["Christian Bale", "Hugh Jackman", "Scarlett Johansson"]) }
  end
  end