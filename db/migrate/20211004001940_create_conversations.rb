class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.string :statut, null: false
      t.integer :receiver_id

      t.timestamps
    end

    add_reference :conversations, :student, foreign_key: true
  end
end
