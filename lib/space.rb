class Space

  attr_reader :name, :description, :price_per_night, :available_from

  @@spaces = []

  def initialize(moneyClass, name, description, price_per_night, available_from)
    @name = name
    @description = description
    @price_per_night = moneyClass.new(price_per_night)
    @available_from = available_from
  end

  def price_per_night_formatted
    price_per_night.format
  end

  def self.all
    @@spaces
  end

end