module Cinema
  class Netflix < MovieCollection
    extend CashBox::MovieCash
    attr_reader :deposit, :myfilter

    def initialize(filmfile)
      super
      @deposit = 0
      @myfilter = {}
    end

    def pay(deposit)
      @deposit += deposit
      self.class.addtocash deposit
    end

    def payment(cost)
      raise 'Извините! У вас недостаточно средств на счете' unless (@deposit - cost) >= 0
      @deposit -= cost
    end

    def show(filters=nil, &block)
      if filters
        if filters[:period]
          filters[:year] = PERIODS[filters[:period]]
          filters.delete(:period)
        end
        film = filter(filters)
      end

      film ||= @allfilms
      film = film.select(&block) if block_given?
      film.sort_by { |f| f.rating.to_i * rand(10) }
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

    def define_filter(filter, &block)
      raise 'Блок обязателен' unless block
      @myfilter[filter] = block
    end
  end
end
