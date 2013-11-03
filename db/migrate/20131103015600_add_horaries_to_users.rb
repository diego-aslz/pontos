class AddHorariesToUsers < ActiveRecord::Migration
  def up
    add_column :users, :horaries, :text
    remove_column :users, :default_morning_start
    remove_column :users, :default_morning_finish
    remove_column :users, :default_afternoon_start
    remove_column :users, :default_afternoon_finish
  end

  def down
    remove_column :users, :horaries
    add_column :users, :default_morning_start, :string, default: '08:00'
    add_column :users, :default_morning_finish, :string, default: '12:00'
    add_column :users, :default_afternoon_start, :string, default: '14:00'
    add_column :users, :default_afternoon_finish, :string, default: '18:00'
  end
end
