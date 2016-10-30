class UnreadTickets	
	def search (no_of_results, params = {})
		# Optional parameters:
		# {category_id: 1, cost: '>= 10', email: 'john@doe.com'}
		tickets = Ticket.where(read: false)
		if category_id = params[:category_id]
			tickets = tickets.where(category_id: category_id)
		end
		if params[:cost]
			begin
				(symbol, value) = params[:cost].match(/([=<>]+)\s+(\d+)/).captures
				tickets = tickets.where("cost #{symbol} ?", value.to_i)
			rescue
				raise "Wrong cost parameter format"
			end
		end
		if params[:email]
			tickets = tickets.where(email: params[:email])
		end
		tickets.order(created_at: :desc).limit(no_of_results).update(read: true)
	end
end