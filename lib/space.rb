class Space

  attr_reader :name, :description, :price_per_night, :available_from, :available_to, :id, :user_id

  def initialize(id, name, description, price_per_night, available_from, available_to, user_id)
    @name = name
    @description = description
    @price_per_night = price_per_night
    @available_from = available_from
    @available_to = available_to
    @id = id
    @user_id = user_id
  end

  def price_per_night_formatted
    price_per_night.format
  end

  def self.all
    spaces = []
    DatabaseConnection.query("SELECT * FROM spaces").each do |space|
      spaces << Space.new(space['id'], space['name'], space['description'], Money.new(space['price']), Date.parse(space['available_from']), Date.parse(space['available_to']), space['user_id'])
    end
    spaces
  end

  def save
    DatabaseConnection.query("INSERT INTO spaces(name, description, price, available_from, available_to) VALUES('#{@name}', '#{@description}', #{@price_per_night.fractional}, '#{@available_from.strftime('%Y-%m-%d')}', '#{@available_to.strftime('%Y-%m-%d')}') RETURNING id, name, description, price, available_from, available_to;")
  end

  def self.find(id)
    space = DatabaseConnection.query("SELECT * FROM spaces WHERE id='#{id}'")
    p '----------------'
    p space[0]['id']
    Space.new(space[0]['id'], space[0]['name'], space[0]['description'], Money.new(space[0]['price']), Date.parse(space[0]['available_from']), Date.parse(space[0]['available_to']), space[0]['user_id'])
  end
  
end
