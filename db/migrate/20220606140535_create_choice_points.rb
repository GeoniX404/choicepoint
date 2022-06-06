class CreateChoicePoints < ActiveRecord::Migration[6.1]
  def change
    create_table :choice_points do |t|
      t.string :title
      t.text :description
      t.date :deadline
      t.boolean :successful
      t.text :feedback
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
