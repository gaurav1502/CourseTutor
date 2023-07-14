class CreateTutors < ActiveRecord::Migration[7.0]
  def change
    create_table :tutors do |t|
      t.string :name
      t.string :tutor_id
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end