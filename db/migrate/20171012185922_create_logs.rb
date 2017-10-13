class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :description
      t.decimal :cost, precision: 7, scale: 2
      t.timestamps
    end
  end
end
