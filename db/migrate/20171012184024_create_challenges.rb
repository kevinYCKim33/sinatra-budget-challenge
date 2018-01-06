class CreateChallenges < ActiveRecord::Migration[5.0]
  def change
    create_table :challenges do |t|
      t.string :name
      t.integer :user_id
      t.decimal :budget, precision: 7, scale: 2
      t.integer :days
      t.timestamps
    end
  end
end
