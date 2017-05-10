module Cinema
  class Netflix < MovieCollection
    extend CashBox::MovieCash
    attr_reader :deposit

    def initialize(filmfile)
      super
      @deposit = 0
    end

    def pay(deposit)
      @deposit += deposit
      self.class.addtocash deposit
    end

    def payment(cost)
      raise 'Извините! У вас недостаточно средств на счете' unless (@deposit - cost) >= 0
      @deposit -= cost
    end

    def show(filters)
      if filters[:period]
        filters[:year] = PERIODS[filters[:period]]
        filters.delete(:period)
      end
      filter(filters).sort_by { |f| f.rating.to_i * rand(10) }
                     .reverse.first(1)
                     .inject([]) { |arr, f| arr << "Фильм: #{f.description} #{f.watch}" }
    end

    def how_much?(film)
      currency = Money.new(1000, 'USD').currency
      film = filter(name: film)[0]
      "#{film.description} - просмотр фильма стоит "\
      "#{Money.new(100 * film.cost, 'USD')}#{currency.symbol}, на вашем счете "\
      "#{Money.new(100 * @deposit, 'USD')}#{currency.symbol}"
    end
  end
end
