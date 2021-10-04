class CreateFields < ActiveRecord::Migration[5.2]
  def change
    create_table :fields do |t|
      t.string :name, null: false
      t.string :acronym, null: false

      t.timestamps
    end

    add_reference :fields, :university, foreign_key: true
  end
end
