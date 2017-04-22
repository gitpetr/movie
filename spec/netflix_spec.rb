RSpec.describe Netflix do
  let(:netflix) { Netflix.new(File.expand_path("../../app/movies.txt", __FILE__)) }
  before{ netflix.pay(18) }
  describe "#show" do
    

    subject {netflix.show(genre: /Sci-Fi|Comedy|Romance|Drama/, period: :modern) }
    it { expect { subject }.to output(/Фильм:(.*)современное кино \( \d{4}, - \d{2,3} min\)\. Играют(.*)Оплата просмотра фильма(.*)на счете осталось \$(\d{2})/).to_stdout }
  end
 
end
