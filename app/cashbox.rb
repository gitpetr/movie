module Cinema
  module CashBox
    module MovieCash
      def cash
        @cash ||= 0
        @cash
      end

      def addtocash(add)
        @cash = cash + add
      end

      def take(who)
        raise 'Попытка взлома кассы. Вызвана полиция.' unless who == 'Bank'
        "Проведена инкассация. В кассе #{@cash = 0} долларов"
      end
    end
  end
end
