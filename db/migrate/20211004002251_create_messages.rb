class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :content, null: false
      t.timestamps
    end

    add_reference :messages, :student, foreign_key: true
    add_reference :messages, :conversation, foreign_key: true
  end
end
