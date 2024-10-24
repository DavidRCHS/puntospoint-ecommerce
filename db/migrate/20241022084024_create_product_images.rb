class CreateProductImages < ActiveRecord::Migration
  def self.up
    create_table :product_images do |t|
      t.integer :imageable_id
      t.string :imageable_type
      t.string :url

      t.timestamps
    end

    add_index :product_images, [:imageable_id, :imageable_type]
  end

  def self.down
    drop_table :product_images
  end
end
