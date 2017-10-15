class RemoveDaysColumn < ActiveRecord::Migration
  def change
    remove_column(:challenges, :days)
  end
end
