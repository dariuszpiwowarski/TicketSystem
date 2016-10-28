class Ticket < ApplicationRecord
  belongs_to :category
  validates :description, :category_id, :email, presence: true
  validates :description, length: { minimum: 100 }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
  	message: "Email format is not valid"
  }

  before_save :add_cost_and_due_date

  private

  def add_cost_and_due_date
  	price_and_fix_time_map = Category.price_and_fix_time_map
  	
  	if category = price_and_fix_time_map[self.category.name.to_sym]
  		curr_time = Time.now
  		# Check if this ticket has special cost / due date
  		category[:hours_range] && category[:hours_range].each do |h_range, data|
  			if h_range.cover?(curr_time.strftime('%H:%M'))
  				set_cost_and_due_date(data, curr_time)
  			end
  		end
  		# If not use defaults
  		unless (self.cost && self.due_date)	
  			set_cost_and_due_date(category[:default], curr_time)
  		end
  	end  	
  end

  def set_cost_and_due_date (data, curr_time)
  	self.cost = data[:cost]
		if h = data[:hours]
			self.due_date = curr_time + h.hours
		elsif bd = data[:business_days]
			self.due_date = bd.business_days.from_now
		end
  end
end