require_relative('./models/customer')
require_relative('./models/film')
require_relative('./models/ticket')
require_relative('./models/screening')
require ('pry-byebug')

Customer.delete_all
Film.delete_all
Ticket.delete_all
# Screening.delete_all

customer1 = Customer.new({'name'=>'Bram','funds'=> '6'})
customer2 = Customer.new({'name'=>'Mitch','funds'=> '10'})
customer3 = Customer.new({'name'=>'Matty','funds'=> '200'})
customer4 = Customer.new({'name'=>'Aynsley','funds'=> '100'})

customer1.save()
customer2.save()
customer3.save()
customer4.save()

film1 = Film.new( {'title' => 'LOTR', 'price' => '10'} )
film2 = Film.new( {'title' => 'Prisoners', 'price' => '20'} )
film3 = Film.new( {'title' => 'Prometheus', 'price' => '6'} )

film1.save()
film2.save()
film3.save()

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id,'timing' => '16:00'})
ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film1.id,'timing' => '16:00'})
ticket3 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film3.id,'timing' => '17:00'})
ticket4 = Ticket.new({'customer_id' => customer4.id, 'film_id' => film2.id,'timing' => '20:00'})
ticket5 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id,'timing' => '20:00'})
ticket6 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id,'timing' => '20:00'})
ticket7 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film2.id,'timing' => '18:00'})

ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()
ticket5.save()
ticket6.save()
ticket7.save()

# screening1 = Screening.new({'timing' => '20:00'})
# screening2 = Screening.new({'timing' => '16:00'})
# screening3 = Screening.new({'timing' => '22:00'})
# screening4 = Screening.new({'timing' => '22:00'})
#
#
# screening1.save()
# screening2.save()
# screening3.save()
# screening4.save()

binding.pry
nil
