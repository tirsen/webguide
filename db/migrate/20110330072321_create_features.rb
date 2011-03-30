class CreateFeatures < ActiveRecord::Migration
  def self.up
    create_table :features do |t|
      t.string :name
      t.string :triposo_id
      t.string :type
      t.string :poicat
      t.string :poitype
      t.float :lat
      t.float :lng
      t.float :score
      t.text :html
    end
    add_index :features, :triposo_id, { :unique => true }
    add_index :features, :lat
    add_index :features, :lng
    add_index :features, :score
  end

  def self.down
    drop_table :features
  end
end
