class AddUserReferenceToRewardHistories < ActiveRecord::Migration[7.1]
  def change
    add_reference :reward_histories, :user, null: true, foreign_key: true
  end
end
