class AddUserToPeriods < ActiveRecord::Migration
  def change
    add_column :periods, :user_id, :integer
    add_index :periods, :user_id
  end
end
