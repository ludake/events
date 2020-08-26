class RenamePasswordToHashedPassword < ActiveRecord::Migration[5.2]
  def self.up
    rename_column :users, :password, :hashed_password
  end

  def self.down
    rename_column :users, :hashed_password, :password
  end
end
