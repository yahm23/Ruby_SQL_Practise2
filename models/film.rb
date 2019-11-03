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

  def most_pop#ular_showing
    sql = "SELECT * FROM tickets WHERE tickets.film_id = $1"
    values= [@id]
    tickets = SqlRunner.run(sql, values)
    screening_ids = tickets.map{|ticket| Ticket.new(ticket).screening_id} #array of screening ids, need a way to take mode
    # return screening_ids
    most_pop_id = screening_ids.max_by { |i| screening_ids.count(i) }
    sql2 = "SELECT * FROM screenings WHERE screenings.id = $1"
    values2 =[most_pop_id]
    screening = SqlRunner.run(sql2,values2)
    popular_time = screening.map{|sc|Screening.new(sc).timing}
    # return popular_time[0]
    return "The most popular showing for #{self.title} is #{popular_time[0]}"
  end



end
