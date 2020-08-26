class CreateCategoriesEvents < ActiveRecord::Migration[5.2]
  def self.up
    create_table :categories_events, :id => false do |t|
      t.column :event_id, :integer
      t.column :category_id, :integer
    end
  end

  def self.down
    drop_table :categories_events
  end
end
