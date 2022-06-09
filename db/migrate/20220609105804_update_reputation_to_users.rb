class UpdateReputationToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :reputation, from: nil, to: 1
  end
end
