class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.string :state
      t.decimal :total
      t.references :paymentcategory, polymorphic: true

      t.timestamps
    end
  end
end
