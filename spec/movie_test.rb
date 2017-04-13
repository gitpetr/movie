require 'rspec'
require 'csv' 
require_relative '../movie_collection'
TITRES = %i[link name  year country date  genre duratation rating director actors]
require_relative '../movie'
 
RSpec.describe MovieCollection  do 
  let(:listfilms) {  MovieCollection.new("../movies.txt") }
  
  describe '#all' do 
    subject { listfilms.all }
    it { is_expected 
        .to have_attributes(count: 250)
        .and all be_an_instance_of(Movie)
      }
  end
  
  describe "#sortby" do 
    subject { listfilms.sortby(:year).first.year }
    it { is_expected.to eq(1921) }
  end

  describe "#actors" do 
    subject { listfilms.actors.first }
    it { is_expected.to match_array(["Bob Gunton", "Morgan Freeman", "Tim Robbins"])}
  end

  describe '#stats' do 
    context "по режиссерам" do
      subject { listfilms.stats(:director) }
      it { is_expected.to include("Zemeckis Robert" => 2) }
    end 

    context "по году" do
      subject { listfilms.stats(:year) }
      it { is_expected.to include(2010 => 7) }
    end 

    context "по актерам" do
      subject { listfilms.stats(:actors) }
      it { is_expected.to include("Al Pacino" => 5) }
    end 

    context "по незнакомому полю" do
      subject { listfilms.stats(:produsser) }
      it { expect { subject }.to raise_error(NoMethodError) }
    end 

    context "по месяцам" do
      subject { listfilms.stats(:month) }
      it { is_expected.to include("12" => 30) }
    end 

  end

  describe '#filter' do 
      subject { listfilms.filter( year: (1945..2010),
                                  genre: /Sci-Fi|Comedy|Romance|Drama/,
                                  actors: /Johansson|Elizabeth|Julie Delpy/ ).first }
      it { is_expected.to have_attributes(:year => 2006,
                                          :genre => ["Drama", "Mystery", "Thriller"],
                                          :actors => ["Christian Bale", "Hugh Jackman", "Scarlett Johansson"]) }
  end
end
