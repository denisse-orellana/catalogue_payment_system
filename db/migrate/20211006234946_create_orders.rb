class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :number
      t.decimal :total
      t.string :state
      t.references :payment, foreign_key: true

      t.timestamps
    end
  end
end
