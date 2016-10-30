class Category < ApplicationRecord
	has_many :ticket
	validates :name, presence: true
	validates :name, uniqueness: true	

	def self.price_and_fix_time_map 
		# This probably shouble be stored in the DB
		{
	  		:Failure => {
	  			:hours_range => {
		  			'17:00'..'23:59' => {
		  				:cost => 100,
		  				:hours => 4
		  			},
		  			'00:00'..'08:59' => {
		  				:cost => 100	,
		  				:hours => 4
	  				}
	  			},
	  			:default => {
	  				:cost => 50,
	  				:hours => 4
	  			}
	  		},
	  		:Damage => {
	  			:default => {
	  				:cost => 10,
	  				:business_days => 3
	  			}
	  		},
	  		:Malfunction => {
	  			:default => {
	  				:cost => 1,
	  				:business_days => 1
	  			}
	  		}
  		}
  end
end
