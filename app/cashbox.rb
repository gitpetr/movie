module CashBox

  module GeneralCash
      module ClassMethods
        @@cash = 0

        def cash
          @@cash
        end

        def deposit_cash deposit
          @@cash += deposit 
        end
      end

      def self.included base 
        base.extend ClassMethods 
      end

  end

  module MovieCash

    def cash
      @cash
    end 

    def take(who)
      raise "Попытка взлома кассы. Вызвана полиция. \a\a\a\a\a\a\a\a\a\a\a\a\a\a\a\a\a\a\a" unless who == "Bank"
      puts "Проведена инкассация. В кассе #{@cash=0} долларов"
    end

  end
end