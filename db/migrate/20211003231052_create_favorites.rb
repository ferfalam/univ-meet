class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.timestamps
    end

    add_reference :favorites, :post, foreign_key: true
    add_reference :favorites, :student, foreign_key: true
  end
end
