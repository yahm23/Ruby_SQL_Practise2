require_relative('../db/sql_runner.rb')

class Film
  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films(title, price) VALUES ($1,$2) RETURNING id"
    values =[@title,@price]
    output = SqlRunner.run(sql,values)[0]
    @id = output['id'].to_i
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values=[@title,@price,@id]
    SqlRunner.run(sql,values)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values=[@id]
    SqlRunner.run(sql,values)
  end

  def customers
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON tickets.customer_id = customers.id WHERE film_id = $1"
    values =[@id]
    outputs = SqlRunner.run(sql,values)
    return outputs.map{|output| Customer.new(output)}
  end

  def customer_count
    return self.customers.length
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def most_popular_showing
    sql = "SELECT * FROM tickets WHERE tickets.film_id = $1"
    values= [@id]
    tickets_SQL = SqlRunner.run(sql, values)
    tickets = tickets_SQL.map{|ticket| Ticket.new(ticket)}
    return tickets
  end



end
