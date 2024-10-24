class CreateAdmins < ActiveRecord::Migration
  def self.up
    create_table :admins do |t|
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end

  def self.down
    drop_table :admins
  end
end
