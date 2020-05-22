require 'pg'
require 'date'
require_relative 'database_connection'

class Booking
  attr_reader :id, :space_id, :user_id, :status, :date

  def initialize(id:, space_id:, user_id:, date:, status:)
    @id = id
    @space_id = space_id
    @user_id = user_id
    @date = DateTime.parse(date)
    @status = status
  end

  def print_date
    @date.strftime('%d - %b - %Y')
  end

  def self.create(space_id:, user_id:, date:)
    result = DatabaseConnection.query("INSERT INTO bookings (date, space_id, user_id, status)
                                    VALUES('#{date}', '#{space_id}', '#{user_id}', '#{'unconfirmed'}')
                                    RETURNING id, date, space_id, user_id, status;")

    instance(result[0])
  end

  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM bookings WHERE id = #{id}")
    instance(result[0])
  end

  def self.find_by_user(id:)
    result = DatabaseConnection.query("SELECT * FROM bookings WHERE user_id = #{id} ")
    result.map{ |booking| instance(booking) }
  end

  def self.find_by_space(id:)
    result = DatabaseConnection.query("SELECT * FROM bookings WHERE space_id = #{id}")
    result.map{ |booking| instance(booking) }
  end

  def self.instance(booking)
    Booking.new(id: booking['id'],
             space_id: booking['space_id'],
              user_id: booking['user_id'],
                 date: booking['date'],
               status: booking['status'])
  end

  def set_status(status)
    DatabaseConnection.query("UPDATE bookings SET status = '#{status}' WHERE id = #{@id};")
  end

  private_class_method :instance
end

# def self.find(user_id:)
#   result = DatabaseConnection.query("SELECT * FROM bookings WHERE user_id = #{user_id}")
#   instance(result)
# end

# def self.all
#     result = DatabaseConnection.query("SELECT * FROM bookmarks")
#     result.map { |bookmark| instance(bookmark)}
#   end
#
#   def self.create(url:, title:)
#     result = DatabaseConnection.query("INSERT INTO bookmarks (url, title)
#                               VALUES('#{url}', '#{title}')
#                               RETURNING id, title, url;")
#
#     Bookmark.new(id: result[0]['id'],
#                  title: result[0]['title'],
#                  url: result[0]['url'])
#   end
#
#   def self.delete(id:)
#     DatabaseConnection.query("DELETE FROM bookmarks WHERE id = #{id}")
#   end
