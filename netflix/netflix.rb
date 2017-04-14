# require '../movie_collection.rb'
class Netflix < MovieCollection

  def show(filters)
    def director_films(name)
      filter(director: name).first(10).each{ |f| f}.join(',')
    end

    if filters[:period]
      filters[:year] =  period[filters[:period]]
      type = typofperiod filters[:period]
      period = filters[:period]
      filters.delete(:period)
    end

    filter(filters).each do |f| puts "\t Now showing: #{f.name}\
     - #{type}(#{f.year}), #{ "режиссер " + f.director if period == :classic}  (время начала) - (время окончания)"
     puts("другие картины этого режиссера: ", director_films(f.director), "-------------------------------------------") 
    end
  end

  
end