class CreateDigitals < ActiveRecord::Migration[5.2]
  def change
    create_table :digitals do |t|
      t.string :name

      t.timestamps
    end
  end
end
