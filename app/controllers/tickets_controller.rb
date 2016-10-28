class TicketsController < ApplicationController
	def index
		@tickets = Ticket.all
		flash[:notice] = 'The ticket was saved'
	end

	def new
		@ticket = Ticket.new
	end

	def create
		@ticket = Ticket.new(ticket_params)
		if @ticket.save
			redirect_to :tickets
		else
			render 'new'
		end
	end

	private
	def ticket_params
		params.require(:ticket).permit(:description, :email, :category_id);
	end
end
