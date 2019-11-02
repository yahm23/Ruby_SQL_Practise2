require_relative('../db/sql_runner.rb')

class Customer
  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers(name, funds) VALUES ($1,$2) RETURNING id"
    values =[@name,@funds]
    output = SqlRunner.run(sql,values)[0]
    @id = output['id'].to_i
  end

  def update()
    sql = "UPDATE customers  SET (name , funds)= ($1, $2) WHERE id = $3"
    values =[@name,@funds,@id]
    SqlRunner.run(sql,values)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values=[@id]
    SqlRunner.run(sql,values)
  end

  def films()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON tickets.film_id = films.id WHERE customer_id = $1"
    values=[@id]
    outputs = SqlRunner.run(sql,values)
    return outputs.map{|output| Film.new(output)}
  end

  def buy_ticket()
    films = self.films
    cost_tot=0
    cost = films.map{|film| cost_tot += film.price}
    @funds = @funds - cost_tot
    return "Remaining funds for #{@name} is #{@funds}"
  end

  def ticket_count()
    sql = "SELECT * FROM tickets WHERE tickets.customer_id =$1"
    values = [@id]
    ticks = SqlRunner.run(sql,values)
    output = ticks.map{|tick| Ticket.new(tick)}
    return output.length
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end
end
