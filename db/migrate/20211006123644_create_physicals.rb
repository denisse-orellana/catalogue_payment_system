class CreatePhysicals < ActiveRecord::Migration[5.2]
  def change
    create_table :physicals do |t|
      t.string :name

      t.timestamps
    end
  end
end
