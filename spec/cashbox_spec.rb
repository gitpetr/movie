require_relative '../app/cashbox'
RSpec.describe Cinema::CashBox::MovieCash do
  let(:netflix) { Object.new.extend(Cinema::CashBox::MovieCash) }
  before{ netflix.addtocash 10 }
  describe "@cash" do 
    context "#addtocash" do
      it "when addtocash 10" do 
        expect(netflix.addtocash 10).to eq(20)
      end
    end

    context "#cash" do
      it "when addtocash 10" do 
        expect(netflix.cash ).to eq(10)
      end
    end
  end

  describe "#take" do 
    context "when error" do 
      it "when take 'banka'" do
        expect{netflix.take("banka")}.to raise_error(RuntimeError, "Попытка взлома кассы. Вызвана полиция.")
      end
    end

    context "when Bank" do 
      it "when take 'banka'" do
        netflix.take("Bank")
        expect(netflix.cash ).to eq(0)
      end
    end
  end
end
