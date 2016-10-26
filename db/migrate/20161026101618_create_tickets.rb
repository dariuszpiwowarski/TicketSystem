class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.text :description
      t.string :email
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
