class CreatePurchases < ActiveRecord::Migration
  def self.up
    create_table :purchases do |t|
      t.integer :product_id
      t.integer :customer_id
      t.integer :quantity
      t.decimal :total_price

      t.timestamps
    end

    # Añadir las llaves foráneas hacia Product y Customer
    add_index :purchases, :product_id
    add_index :purchases, :customer_id
  end

  def self.down
    drop_table :purchases
  end
end
