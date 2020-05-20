class Space

  attr_reader :name, :description, :price_per_night, :available_from, :available_to

  @@spaces = []

  def initialize(name, description, price_per_night, available_from, available_to)
    @name = name
    @description = description
    @price_per_night = price_per_night
    @available_from = available_from
    @available_to = available_to
  end

  def price_per_night_formatted
    price_per_night.format
  end

  def self.all
    @@spaces
  end

  def save
    connection = PG.connect(dbname: 'spaced_out_test')
    connection.exec("INSERT INTO spaces(name, description, price, available_from, available_to) VALUES('#{@name}', '#{@description}', #{@price_per_night.fractional}, '#{@available_from.strftime('%Y-%m-%d')}', '#{@available_to.strftime('%Y-%m-%d')}') RETURNING id, name, description, price, available_from, available_to;")
  end

end