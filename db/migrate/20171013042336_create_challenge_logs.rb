class CreateChallengeLogs < ActiveRecord::Migration
  def change
    create_table :challenge_logs do |t|
      t.integer :challenge_id
      t.integer :log_id
    end
  end
end
