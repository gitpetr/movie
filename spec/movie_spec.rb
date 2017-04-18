require 'rspec'
require 'rspec/its'
require 'csv' 
require_relative '../app/movie_collection'
TITRES = %i[link name  year country date  genre duratation rating director actors]
require_relative '../app/movie'
require_relative '../app/ancientmovie'
require_relative '../app/classicmovie'
require_relative '../app/modernmovie'
require_relative '../app/newmovie'

RSpec.describe MovieCollection  do 
  let(:listfilms) {  MovieCollection.new(File.expand_path("../../app/movies.txt", __FILE__)) }
  
  describe '#all' do 
    subject { listfilms.all }
    its(:count) { is_expected.to eq(250) }
    it { is_expected.to all be_a(Movie)}
  end
  
  describe "#sortby" do 
    subject { listfilms.sortby(:year).first }
    its(:year) { is_expected.to eq(1921) }
  end

  describe "#actors" do 
    subject { listfilms.actors }
    its(:first) { is_expected.to match_array(["Bob Gunton", "Morgan Freeman", "Tim Robbins"])}
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
