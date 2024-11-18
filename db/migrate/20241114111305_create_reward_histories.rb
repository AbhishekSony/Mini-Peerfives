# frozen_string_literal: true

class CreateRewardHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :reward_histories do |t|
      t.datetime :timestamp
      t.integer :points
      t.string :given_by
      t.string :given_to

      t.timestamps
    end
  end
end
