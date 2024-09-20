class UpdateStudentsTable < ActiveRecord::Migration[7.1]
  def change
    change_table :students do |t|
      t.change :first_name, :string, null: false
      t.change :last_name, :string, null: false
      t.change :school_email, :string, null: false
      t.change :major, :string, null: false
      t.remove :minor
    end
  end
end
