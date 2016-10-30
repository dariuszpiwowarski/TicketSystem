require 'test_helper'

class TicketsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get '/tickets/'
    assert_response :success
  end
  test "should get new" do
    get '/tickets/new'
    assert_response :success
    assert_select "h1", "Add new ticket"
  end
  test "create new ticket success" do
  	post '/tickets',
  		params: { ticket: { description: 'A' * 100, category_id: 2, email: 'aa@op.pl' } }
  	assert_response :redirect
  	follow_redirect!
  	assert_response :success
  	assert_equal "The ticket was saved", flash[:notice]
  end
  test "create new ticket failed" do
  	post '/tickets',
  		params: { ticket: { description: 'A' * 100, category_id: 2, email: 'aa' } }
  	assert_response :success  	
  	assert_select "span", "Email format is not valid", 'Wrong email format'

  	post '/tickets',
  		params: { ticket: { description: 'A', category_id: 2, email: 'aa@op.pl' } }
  	assert_response :success  	
  	assert_select "span", "is too short (minimum is 100 characters)", 'Description is too short'

  	post '/tickets',
  		params: { ticket: { description: 'A' * 100, email: 'aa@op.pl' } }
  	assert_response :success  	
  	assert_select 'div.ticket_category span', "can't be blank", 'Category is not selected'
  end
end
