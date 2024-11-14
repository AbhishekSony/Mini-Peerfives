class AddBalancesToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :p5_balance, :integer
    add_column :users, :rewards_balance, :integer
  end
end
