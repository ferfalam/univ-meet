class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.string :title, null: false
      t.text :description
      t.boolean :approve, default: false
      t.boolean :rejet, default: false

      t.timestamps
    end

    add_reference :requests, :university, foreign_key: true
    add_reference :requests, :student, foreign_key: true
  end
end
