class Ticket < ApplicationRecord
  belongs_to :category
  validates :description, :category_id, :email, presence: true
  validates :description, length: { minimum: 100 }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
  	message: "Email format is not valid"
  } 
end