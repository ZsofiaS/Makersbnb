require 'pg'
require 'date'
require_relative 'database_connection'

class Booking
  attr_reader :id, :space_id, :user_id, :status

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

    instance(result)
  end

  def self.find(user_id:)
    result = DatabaseConnection.query("SELECT * FROM bookings WHERE user_id = #{user_id}")
    instance(result)
  end

  def self.instance(result)
    Booking.new(id: result[0]['id'],
             space_id: result[0]['space_id'],
              user_id: result[0]['user_id'],
                 date: result[0]['date'],
               status: result[0]['status'])
  end

  private_class_method :instance
end

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
