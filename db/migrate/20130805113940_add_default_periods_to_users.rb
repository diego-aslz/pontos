class AddDefaultPeriodsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :default_morning_start, :string, default: '08:00'
    add_column :users, :default_morning_finish, :string, default: '12:00'
    add_column :users, :default_afternoon_start, :string, default: '14:00'
    add_column :users, :default_afternoon_finish, :string, default: '18:00'
  end
end
