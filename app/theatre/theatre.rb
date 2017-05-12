module Cinema
  class Theatre < MovieCollection
    include CashBox::MovieCash
    def initialize(filmfile)
      @cost = 0
      super filmfile
    end

    MORNING = (9..13).freeze
    DAY = (14..18).freeze
    EVENING = (19..24)
    MORNING_SEANS = PERIODS[:ancient]
    DAY_SEANS = /Adventure|Comedy/
    EVENING_SEANS = /Drama|Horror/
    FILTERDAY = { genre: DAY_SEANS }.freeze
    FILTEREVENING = { genre: EVENING_SEANS }.freeze
    FILTERMORNING = { year: PERIODS[:ancient] }.freeze
    TIMES = {
      morning: MORNING,
      day: DAY,
      evening: EVENING
    }.freeze

    FILTRES = {
      morning: FILTERMORNING,
      day: FILTERDAY,
      evening: FILTEREVENING
    }.freeze

    TIMESEANS = {
      morning: { period: :ancient },
      day: { genre: /Adventure|Comedy/ },
      evening: { genre: /Drama|Horror/ }
    }.freeze
    def cost
      {
        morning: 3,
        day: 5,
        evening: 10
      }.freeze
    end

    def show(hour)
      raise "В указанное время сеансов нет \n" unless (MORNING.first..EVENING.last).cover?(hour)
      period = TIMES.detect { |_p, hours| hours.cover?(hour) }[0]
      filter(FILTRES[period]).each(&:description)
    end

    def when?(filmname)
      film = filter(name: filmname).first
      raise 'Такого сеанса нет' unless film
      time, _ = TIMESEANS.detect { |_hours, filtres| film.match_filter?(filtres) }
      @cost = cost[time]
      "Сеансы фильма: #{film.description} идут  c #{TIMES[time].first} по #{TIMES[time].last}"
    end

    def buy_ticket(title)
      currency = Money.new(1000, 'USD').currency
      when? title
      addtocash @cost
      "Оплата #{Money.new(100 * @cost, 'USD')}#{currency.symbol} Вы купили билет на #{title}."
    end
  end
end
