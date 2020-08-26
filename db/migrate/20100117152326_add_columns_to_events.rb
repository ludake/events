class AddColumnsToEvents < ActiveRecord::Migration[5.2]
  def self.up
    add_column :events, :url, :string
    add_column :events, :description, :text
  end

  def self.down
    remove_column :events, :description
    remove_column :events, :url
  end
end
