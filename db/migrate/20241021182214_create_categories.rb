class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.integer :admin_id

      t.timestamps
    end

    add_index :categories, :admin_id
  end

  def self.down
    drop_table :categories
  end
end
