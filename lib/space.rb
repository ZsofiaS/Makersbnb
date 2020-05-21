class Space

  attr_reader :name, :description, :price_per_night, :available_from, :available_to, :id, :image_path

  def initialize(id, name, description, price_per_night, available_from, available_to, image_path)
    @name = name
    @description = description
    @price_per_night = price_per_night
    @available_from = available_from
    @available_to = available_to
    @id = id
    @image_path = image_path
  end

  def price_per_night_formatted
    price_per_night.format
  end

  def self.all
    spaces = []
    DatabaseConnection.query("SELECT * FROM spaces").each do |space|
      spaces << Space.new(space['id'], space['name'], space['description'], Money.new(space['price']), Date.parse(space['available_from']), Date.parse(space['available_to']), space['image_path'])
    end
    spaces
  end

  def save
    DatabaseConnection.query("INSERT INTO spaces(name, description, price, available_from, available_to, image_path) VALUES('#{@name}', '#{@description}', #{@price_per_night.fractional}, '#{@available_from.strftime('%Y-%m-%d')}', '#{@available_to.strftime('%Y-%m-%d')}', '#{@image_path}') RETURNING id, name, description, price, available_from, available_to;")
  end

  def self.find(id)
    space = DatabaseConnection.query("SELECT * FROM spaces WHERE id='#{id}'")
    Space.new(space[0]['id'], space[0]['name'], space[0]['description'], Money.new(space[0]['price']), Date.parse(space[0]['available_from']), Date.parse(space[0]['available_to']))
  end
  
end
