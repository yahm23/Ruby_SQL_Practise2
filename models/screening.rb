require_relative('../db/sql_runner.rb')

class Screening
  attr_reader :id
  attr_accessor :film_title, :timing

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_title = options['film_title']
    @timing = options['timing']
  end

  def save()
    sql = "INSERT INTO screenings(film_title, timing) VALUES ($1,$2) RETURNING id"
    values =[@film_title,@timing]
    output = SqlRunner.run(sql,values)[0]
    @id = output['id'].to_i
  end

  def update()
    sql = "UPDATE screenings SET (film_title,timing) = ($1,$2) WHERE id =$3"
    values=[@film_title,@timing,@id]
    SqlRunner.run(sql,values)
  end

  def delete()
    sql = "DELETE FROM screenings WHERE id = $1"
    values=[@id]
    SqlRunner.run(sql,values)
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

end
