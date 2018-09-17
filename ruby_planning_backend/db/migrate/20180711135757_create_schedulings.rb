class CreateSchedulings < ActiveRecord::Migration[5.1]
  def change
    create_table :schedulings do |t|
      t.string :name
      t.string :description
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.boolean :saturday
      t.boolean :sunday
      t.integer :group_id

      t.timestamps
    end
  end
end
