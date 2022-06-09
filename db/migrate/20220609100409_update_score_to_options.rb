class UpdateScoreToOptions < ActiveRecord::Migration[6.1]
  def change
    change_column_default :options, :score, from: nil, to: 0
  end
end
