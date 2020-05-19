class Space

  attr_reader :name, :description, :price_per_night, :available_from, :available_to

  @@spaces = []

  def initialize(moneyClass, name, description, price_per_night, available_from, available_to)
    @name = name
    @description = description
    @price_per_night = moneyClass.new(price_per_night)
    @available_from = available_from
    @available_to = available_to
  end

  def price_per_night_formatted
    price_per_night.format
  end

  def self.all
    @@spaces
  end

end