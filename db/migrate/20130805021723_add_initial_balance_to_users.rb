class AddInitialBalanceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :initial_balance, :decimal, default: 0
  end
end
