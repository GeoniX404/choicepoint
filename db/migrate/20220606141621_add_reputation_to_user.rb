class AddReputationToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :reputation, :integer
  end
end
