class AddFirstZoomlevel < ActiveRecord::Migration
  def self.up
    add_column :features, :first_zoom_level, :integer
    add_index :features, :first_zoom_level
  end

  def self.down
  end
end
