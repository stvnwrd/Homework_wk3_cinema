require_relative("../db/sql_runner")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save()
    sql = "INSERT INTO films (title, price)
    VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end


  def update()
    sql = "UPDATE films SET (title, price)
    = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE from films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end


  def customers()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON
    customers.id = tickets.customer_id WHERE film_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |customer| Customer.new(customer)  }
  end

  def customers_total()
    sql = "SELECT count(*) AS TOTAL FROM tickets WHERE film_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.first
  end


  def self.find(search)
    sql = "SELECT * FROM films WHERE id = $1"
    values = [search]
    results = SqlRunner.run(sql, values)[0]
    return Film.new(results)
  end


  def self.delete_all()
    sql = "DELETE FROM films"
    values = []
    SqlRunner.run(sql, values)
  end




end
