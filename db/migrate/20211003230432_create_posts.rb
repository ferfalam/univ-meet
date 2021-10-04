class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :content, null: false
      t.string :image

      t.timestamps
    end

    add_reference :posts, :student, foreign_key: true
  end
end
