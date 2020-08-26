class AddImageUrlToEvents < ActiveRecord::Migration[5.2]
  def change
  	   add_column :events, :image_url, :string
  end
end
