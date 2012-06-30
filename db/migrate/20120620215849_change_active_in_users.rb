class ChangeActiveInUsers < ActiveRecord::Migration
  def up
      change_column :users, :active, :boolean, :default => false
      User.update_all ["active = ?", false]
  end

  def down
      change_column :users, :active, :boolean, :default => true
      User.update_all ["active = ?", false]
  end
end
