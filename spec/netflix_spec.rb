RSpec.describe Cinema::Netflix do
  let(:netflix) { Cinema::Netflix.new(File.expand_path('../../app/movies.txt', __FILE__)) }
  before { netflix.pay(18) }
  describe '#show' do
    it "when netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :modern)[0]" do
      expect(netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :modern)[0]).to match(/Фильм:(.*)\(\d{4}, - \d{2,3} min\)(.*)/)
    end

    it "when add &block" do
      expect(netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/) { |movie| movie.name.include?('Terminator') &&
                                                                          movie.year > 1945 }[0])
              .to match(/Фильм:(.*)\(\d{4}, - \d{2,3} min\)\. Играют(.*)Оплата просмотра фильма(.*)на счете осталось(.*)/)
    end
  end

  describe '#how_much?' do
    subject { netflix.how_much?('Gone Girl') }
    it  "when netflix.how_much?('Gone Girl')" do
      expect(netflix.how_much?('Gone Girl')).to match(/Gone Girl/)
    end
  end
end
