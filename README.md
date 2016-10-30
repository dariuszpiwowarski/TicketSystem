#A simple ticket system written in Rails 5

##Database creation
rails db:migrate

##Database initialization
After creating the tables we need to load categories:

rails db:seed

##How to run the test suite 
rails t test/

##Services
There is one service class UnreadTickets.

To use it create an instance of this class:

service = UnreadTickets.new

Usage:

service->search(number_of_results)

The search method returns n of the oldest unread ticket, and changes it's read status to true
The number of results parameter is required.

Additional parameters service->search(n, {params}):
- category_id

  service->search(10, {category_id: 1})
- email

  service->search(10, {email: 'aa@op.pl'})
  
- cost (filters resuts by cost)

  service->search(10, {cost: "=> 10"})
  
  service->search(10, {cost: "< 10"})
  
  service->search(10, {cost: "== 10"})
  
They can be combined:

  service->search(10, {category_id: 1, cost: "< 100", email: 'aa@op.pl')