class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.boolean :done
      t.integer :input_type
      t.string :result
      t.integer :group_id

      t.timestamps
    end
  end
end
