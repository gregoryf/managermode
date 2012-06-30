class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sign_up_token, :string

  end
end
