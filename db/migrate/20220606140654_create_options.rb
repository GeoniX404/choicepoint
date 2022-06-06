class CreateOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :options do |t|
      t.boolean :chosen
      t.text :description
      t.float :score
      t.text :pros
      t.text :cons
      t.references :choice_point, null: false, foreign_key: true

      t.timestamps
    end
  end
end
