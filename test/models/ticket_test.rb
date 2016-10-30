require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  test "validation of ticket" do
	ticket = Ticket.new
	assert_not ticket.save, "Ticket shouldn't be saved"
	ticket.category_id = 1
	assert_not ticket.save, "Ticket shouldn't be saved with only category set"
	ticket.email = 'email@email.com'
	assert_not ticket.save, "Ticket shouldn't be saved without description set"
	ticket.description = "Some description of this ticket." * 10
	assert ticket.save, "Ticket should be saved"
	ticket.description = 'Too short. 100 chars min'
	assert_not ticket.save, "Shouln't save. The description is too shot"
	ticket.description = "Some description of this ticket." * 10
	assert ticket.save
	ticket.email = 'wrongformatofemail'
	assert_not ticket.save, "Shouldn't save with wrong email format"
  end

  test "add_cost_and_due_date callback" do  	
  	# Failure
  	params = {category_id: 1, email: 'email@email.com', description: "Some description of this ticket." * 10}
  	ticket = Ticket.new(params)
  	travel_to Time.new(2016, 10, 31, 17, 04, 44)
  	ticket.save  	
  	assert ticket.cost == 100, 'Cost == 100 for the Failure category, after 17:00'
  	assert ticket.due_date == Time.zone.now + 4.hours, "Tickets due date should be +4h"
  	travel_back
  	travel_to Time.new(2016, 10, 24, 8, 04, 44)
  	ticket = Ticket.new(params)
  	ticket.save
  	assert ticket.cost == 100, 'Cost == 100 for the Failure category, before 9:00'
  	assert ticket.due_date == Time.zone.now + 4.hours, "Tickets due date should be +4h"
  	travel_back
  	travel_to Time.new(2016, 10, 21, 9, 04, 44)
  	ticket = Ticket.new(params)
  	ticket.save
  	assert ticket.cost == 50, 'Cost == 50 for the Failure category between 9:00-17:00'
  	assert ticket.due_date == Time.zone.now + 4.hours, "Tickets due date should be +4h"
  	travel_back

  	# Damage
  	params[:category_id] = 2
  	ticket = Ticket.new(params)
  	ticket.save   	
  	assert ticket.cost == 10, 'Cost == 100 for the Damage category'
  	assert ticket.due_date.round_to(5.minutes) == 3.business_days.from_now.round_to(5.minutes),
  		"Tickets due date should be +3 business days"

  	# Malfunction
    params[:category_id] = 3
  	ticket = Ticket.new(params)
  	ticket.save   	
  	assert ticket.cost == 1, 'Cost == 1 for the Malfunction category'
  	assert ticket.due_date.round_to(5.minutes) == 1.business_days.from_now.round_to(5.minutes),
  		"Tickets due date should be +1 business days"
  end
end
