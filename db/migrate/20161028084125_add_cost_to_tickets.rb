class AddCostToTickets < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :cost, :integer
  end
end
