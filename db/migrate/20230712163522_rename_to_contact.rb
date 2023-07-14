class RenameToContact < ActiveRecord::Migration[7.0]
  def change
    rename_column :tutors, :tutor_id, :contact_number
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
