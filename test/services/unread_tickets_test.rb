require 'test_helper'
class UnreadTicktesTest < ActiveSupport::TestCase
	test "search" do
		Ticket.create([{description: 'a' * 100, email: 'aa@op.pl', category_id: 1},
			{description: 'a' * 100, email: 'aa@op.pl', category_id: 1},
			{description: 'a' * 100, email: 'aa@op.pl', category_id: 1},
			{description: 'a' * 100, email: 'aa@op.pl', category_id: 1},
			{description: 'a' * 100, email: 'aa@op.pl', category_id: 2},
			{description: 'a' * 100, email: 'aa@op.pl', category_id: 2},			
			{description: 'a' * 100, email: 'aa@op.pl', category_id: 2},
			{description: 'a' * 100, email: 'aa@op.pl', category_id: 3},
			{description: 'a' * 100, email: 'bb@op.pl', category_id: 3},
			{description: 'a' * 100, email: 'bb@op.pl', category_id: 3},
			{description: 'a' * 100, email: 'bb@op.pl', category_id: 3}
			])
		
		service = UnreadTickets.new	
		assert 1 == service.search(1).size, 'Search should return 1 tickets'
		assert 2 == service.search(2, {category_id: 2}).size, 'Search should return 2 tickets'
		assert 2 == service.search(2, {email: 'bb@op.pl'}).size, 'Search should return 2 tickets'
		assert 5 == Ticket.where(read: true).size, '5 tickes shoul be read'
	
	end
end