require_relative('../db/sql_runner.rb')

class Ticket
  attr_reader :id
  attr_accessor :customer_id, :film_id, :timing

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    # @screening_id = options['screening_id'].to_i
    @timing = options['timing']
  end

  def save()
    sql = "INSERT INTO tickets(customer_id, film_id, timing) VALUES ($1,$2,$3) RETURNING id"
    values =[@customer_id, @film_id, @timing]
    output = SqlRunner.run(sql,values)[0]
    @id = output['id'].to_i
  end

  def update()
    sql = "UPDATE tickets SET (customer_id, film_id, timing) = ($1, $2, $3) WHERE id =$4"
    values=[@customer_id,@film_id,@timing,@id]
    SqlRunner.run(sql,values)
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1"
    values=[@id]
    SqlRunner.run(sql,values)
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

end
