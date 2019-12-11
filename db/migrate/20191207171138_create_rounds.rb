class CreateRounds < ActiveRecord::Migration[5.2]
  def change
    create_table :rounds do |t|
      t.belongs_to :user
      t.string :course
      t.decimal :rating
      t.decimal :slope
      t.integer :score

      t.timestamps
    end
  end
end
