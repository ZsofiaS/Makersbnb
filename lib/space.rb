require_relative './user'
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
    spaces = DatabaseConnection.query("SELECT * FROM spaces")
    spaces.map { |space| instance(space)}
  end

  def correct_date?
    @available_to.strftime('%k').to_i > @available_from.strftime('%k').to_i
  end

  def save
    DatabaseConnection.query("INSERT INTO spaces(name, description, price, available_from, available_to, user_id) VALUES('#{@name}', '#{@description}', #{@price_per_night.fractional}, '#{@available_from.strftime('%Y-%m-%d')}', '#{@available_to.strftime('%Y-%m-%d')}','#{user_id}') RETURNING id, name, description, price, available_from, available_to, user_id;")
  end

  def self.find(id)
    space = DatabaseConnection.query("SELECT * FROM spaces WHERE id='#{id}'")
    instance(space[0])
  end

  def owner_name
    User.find(@user_id).username
  end

  def self.find_by_user(id)
    spaces = DatabaseConnection.query("SELECT * FROM spaces WHERE user_id=#{id}")
    spaces.map { |space| instance(space)}
  end

  def self.order_by_desc(value)
    spaces = DatabaseConnection.query("SELECT * FROM spaces ORDER BY #{value} DESC;")
    spaces.map { |space| instance(space)}
  end

  def self.order_by_asc(value)
    spaces = DatabaseConnection.query("SELECT * FROM spaces ORDER BY #{value} ASC;")
    spaces.map { |space| instance(space)}
  end

  def self.order_by_dates(starting_date, ending_date)
    spaces = DatabaseConnection.query("SELECT * FROM spaces WHERE available_from >='#{starting_date.strftime('%Y-%m-%d')}' AND available_to <= '#{ending_date.strftime('%Y-%m-%d')}';")
    spaces.map { |space| instance(space)}
  end


  def self.instance(space)
    Space.new(space['id'], space['name'], space['description'], Money.new(space['price']), Date.parse(space['available_from']), Date.parse(space['available_to']), space['user_id'])
  end
 
  private_class_method :instance 

 


end
