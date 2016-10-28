class AddDueDateToTickets < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :due_date, :datetime
  end
end
