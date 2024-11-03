class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :comment
      t.string :reviewable_type
      t.integer :reviewable_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
