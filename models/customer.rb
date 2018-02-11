require_relative("../db/sql_runner")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def save()
    sql = "INSERT INTO customers(name, funds)
    VALUES ($1, $2) RETURNING ID"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end


  def update()
    sql = "UPDATE customers SET (name, funds)
    = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end


  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.* FROM films INNER JOIN tickets
    ON films.id = tickets.film_id WHERE customer_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |film| Film.new(film)  }
  end

  def sufficient_funds?(film)
    @funds >= film.price
  end

  def report_insufficient_funds
    return "Sorry. Insufficient funds for this purchase."
  end

  def buy_ticket(film)
    if sufficient_funds?(film)
      @funds -= film.price
      update
      new_ticket = Ticket.new ({ 'customer_id' => @id, 'film_id' => film.id})
      new_ticket.save
    else
      report_insufficient_funds
    end
  end

  def how_many_tickets()
    sql = "SELECT count(*) AS TOTAL FROM tickets WHERE customer_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.first
  end



  def self.find(search)
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [search]
    results = SqlRunner.run(sql, values)[0]
    return Customer.new(results)
  end


  def self.delete_all
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end


end
