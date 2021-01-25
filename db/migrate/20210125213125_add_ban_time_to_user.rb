class AddBanTimeToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :ban_time, :datetime
  end
end
