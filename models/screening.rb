# require_relative('../db/sql_runner.rb')
#
# class Screening
#   attr_reader :id
#   attr_accessor :timing
#
#   def initialize(options)
#     @id = options['id'].to_i if options['id']
#     @ticket_id = options['ticket_id']
#     # @timing = options['timing']
#   end
#
#   def save()
#     sql = "INSERT INTO screenings(ticket_id) VALUES ($1) RETURNING id"
#     values =[@ticket_id]
#     output = SqlRunner.run(sql,values)[0]
#     @id = output['id'].to_i
#   end
#
#   def update()
#     sql = "UPDATE screenings SET (ticket_id) = ($1) WHERE id =$3"
#     values=[@ticket_id,@id]
#     SqlRunner.run(sql,values)
#   end
#
#   def delete()
#     sql = "DELETE FROM screenings WHERE id = $1"
#     values=[@id]
#     SqlRunner.run(sql,values)
#   end
#
#   def self.delete_all()
#     sql = "DELETE FROM screenings"
#     SqlRunner.run(sql)
#   end
#
# end
