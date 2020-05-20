class Space

  attr_reader :name, :description, :price_per_night, :available_from, :available_to, :id

  def initialize(id=nil, name, description, price_per_night, available_from, available_to)
    @name = name
    @description = description
    @price_per_night = price_per_night
    @available_from = available_from
    @available_to = available_to
    @id = id
  end

  def price_per_night_formatted
    price_per_night.format
  end

  def self.all
    spaces = []
    DatabaseConnection.query("SELECT * FROM spaces").each do |space|
      spaces << Space.new(space['id'], space['name'], space['description'], Money.new(space['price']), Date.parse(space['available_from']), Date.parse(space['available_to']))
    end
    spaces
  end

  def save
    connection = PG.connect(dbname: 'spaced_out_test')
    connection.exec("INSERT INTO spaces(name, description, price, available_from, available_to) VALUES('#{@name}', '#{@description}', #{@price_per_night.fractional}, '#{@available_from.strftime('%Y-%m-%d')}', '#{@available_to.strftime('%Y-%m-%d')}') RETURNING id, name, description, price, available_from, available_to;")
  end

  def self.find(id)
    space = DatabaseConnection.query("SELECT * FROM spaces WHERE id='#{id}'")
    Space.new(space[0]['id'], space[0]['name'], space[0]['description'], Money.new(space[0]['price']), Date.parse(space[0]['available_from']), Date.parse(space[0]['available_to']))
  end
  
end
