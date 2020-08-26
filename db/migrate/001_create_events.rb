
class CreateEvents < ActiveRecord::Migration[5.2]
  def self.up
    create_table :events do |t|
      t.string  :title
      t.string  :location
      t.date    :occurs_on
      
      t.timestamps
      
    end
    
  end

  def self.down
    drop_table :events
  end
end
