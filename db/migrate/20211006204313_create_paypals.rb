class CreatePaypals < ActiveRecord::Migration[5.2]
  def change
    create_table :paypals do |t|
      t.string :user_ip

      t.timestamps
    end
  end
end
