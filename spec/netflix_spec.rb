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
