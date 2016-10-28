class AddReadToTickets < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :read, :boolean, default: false
  end
end
