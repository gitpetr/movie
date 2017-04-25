module CashBox
  module ClassMethods
    @@deposit = 10

    def cashbox
      @@deposit
    end

    def depo(pay)
      @@deposit+=pay
    end

    def payment(cost)
      raise "Извините! У вас недостаточно средств на счете" unless  (depo(-cost)) >= 0
      depo(-cost)
    end 

    def take(who)
      raise "Попытка взлома кассы. Вызвана полиция. \a\a\a\a\a\a\a\a\a\a\a\a\a\a\a\a\a\a\a" unless who == "Bank"
      puts "Проведена инкассация. В кассе #{@@deposit=0} долларов"
    end

  end

  module InstansMethods

    def pay(deposit)
      self.class.depo deposit
    end

  end

  def self.included base 
    base.extend ClassMethods 
    base.class_eval do
      include InstansMethods
    end
  end

end