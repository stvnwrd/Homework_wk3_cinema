require_relative ( 'models/customer')
require_relative ( 'models/film' )
require_relative ( 'models/ticket' )

require( 'pry-byebug')


Ticket.delete_all()
Film.delete_all()
Customer.delete_all()


customer1 = Customer.new({ 'name' => 'Hector Pacino', 'funds' => 50})
customer1.save()
customer2 = Customer.new({ 'name' => 'Agnes Johansson', 'funds' => 60})
customer2.save()
customer3 = Customer.new({ 'name' => 'Barry Snipes', 'funds' => 30})
customer3.save()
customer4 = Customer.new({ 'name' => 'Fred De Niro', 'funds' => 20})
customer4.save()
customer5 = Customer.new({ 'name' => 'Brian Davis Jr', 'funds' => 70})
customer5.save()
customer6 = Customer.new({ 'name' => 'Vera Jolie', 'funds' => 80})
customer6.save()

film1 = Film.new({'title' => 'Anchorman - Premium Edition', 'price' => 25})
film1.save()
film2 = Film.new({'title' => 'Black Panther', 'price' => 10})
film2.save()
film3 = Film.new({'title' => 'Coco', 'price' => 9})
film3.save()
film4 = Film.new({'title' => 'Early Man', 'price' => 8})
film4.save()

ticket1 = Ticket.new ({ 'customer_id' => customer1.id, 'film_id' => film2.id})
ticket1.save()
ticket2 = Ticket.new ({ 'customer_id' => customer2.id, 'film_id' => film1.id})
ticket2.save()
ticket3 = Ticket.new ({ 'customer_id' => customer5.id, 'film_id' => film2.id})
ticket3.save()
ticket4 = Ticket.new ({ 'customer_id' => customer6.id, 'film_id' => film4.id})
ticket4.save()
ticket5 = Ticket.new ({ 'customer_id' => customer3.id, 'film_id' => film3.id})
ticket5.save()
ticket6 = Ticket.new ({ 'customer_id' => customer2.id, 'film_id' => film3.id})
ticket6.save()
ticket7 = Ticket.new ({ 'customer_id' => customer5.id, 'film_id' => film4.id})
ticket7.save()
ticket8 = Ticket.new ({ 'customer_id' => customer6.id, 'film_id' => film2.id})
ticket8.save()



binding.pry
nil
