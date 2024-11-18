# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :p5_balance, default: 100
      t.integer :reward_balance, default: 0

      t.timestamps
    end
  end
end
