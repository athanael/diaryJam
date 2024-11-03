class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.string :commentable_type
      t.integer :commentable_id
      t.text :comment_content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
