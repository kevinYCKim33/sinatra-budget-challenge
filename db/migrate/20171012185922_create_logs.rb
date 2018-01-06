class CreateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :logs do |t|
      t.string :description
      t.decimal :cost, precision: 7, scale: 2
      t.timestamps
    end
  end
end
