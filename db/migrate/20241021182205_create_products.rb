class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.integer :admin_id

      t.timestamps
    end

    add_index :products, :admin_id
  end

  def self.down
    drop_table :products
  end
end
