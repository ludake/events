class CreateUsers < ActiveRecord::Migration[5.2]
  def self.up
    create_table :users do |t|
      t.string :login
      t.string :email
      t.string :password

      t.timestamps
    end
    
    
    add_column :events, :user_id, :integer
  end

  def self.down
    drop_table :users
    remove_column :events, :user_id
  end
end
