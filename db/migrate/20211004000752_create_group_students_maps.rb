class CreateGroupStudentsMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :group_students_maps do |t|
      t.timestamps
    end

    add_reference :group_students_maps, :student, foreign_key: true
    add_reference :group_students_maps, :group, foreign_key: true
  end
end
