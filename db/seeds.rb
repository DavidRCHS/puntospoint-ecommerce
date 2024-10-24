# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Create admins
admin_names = ['Alice Johnson', 'Bob Smith', 'Charlie Brown', 'David Lee', 'Eve Taylor']
admin_emails = ['alice@example.com', 'bob@example.com', 'charlie@example.com', 'david@example.com', 'eve@example.com']
admin_password = 'password'  # Puedes cambiarla por cualquier otra contraseña para todos los admins

admin_names.each_with_index do |name, index|
  Admin.create!(
    name: name,
    email: admin_emails[index],
    password_digest: Digest::SHA256.hexdigest(admin_password) # Encripta la contraseña
  )
end

# Create categories
categories = [
  { name: 'Electronics', admin_id: 1 },
  { name: 'Clothing', admin_id: 5 },
  { name: 'Books', admin_id: 3 },
  { name: 'Toys', admin_id: 2 },
  { name: 'Home', admin_id: 3 },
  { name: 'Sports', admin_id: 1 },
  { name: 'Garden', admin_id: 4 },
  { name: 'Automotive', admin_id: 4 },
  { name: 'Beauty', admin_id: 2 },
  { name: 'Health', admin_id: 5 }
]

categories.each do |category|
  Category.where(name: category[:name]).first ||
    Category.create!(name: category[:name], admin_id: category[:admin_id])
end

# Create products
products = [
  { name: 'Smartphone', description: 'Latest 5G smartphone', price: 399.99, categories: ['Electronics', 'Home'] },
  { name: 'Laptop', description: 'Lightweight laptop', price: 899.99, categories: ['Electronics', 'Home'] },
  { name: 'Wireless Headphones', description: 'Noise-canceling headphones', price: 199.99, categories: ['Electronics', 'Toys'] },
  { name: 'Smartwatch', description: 'Waterproof smartwatch', price: 149.99, categories: ['Electronics', 'Sports'] },
  { name: 'Bluetooth Speaker', description: 'Portable speaker with deep bass', price: 79.99, categories: ['Electronics', 'Home'] },
  { name: 'T-Shirt', description: 'Cotton T-shirt', price: 19.99, categories: ['Clothing', 'Home'] },
  { name: 'Jeans', description: 'Slim-fit jeans for men', price: 49.99, categories: ['Clothing', 'Home'] },
  { name: 'Fiction Novel', description: 'Bestselling novel', price: 12.99, categories: ['Books', 'Home'] },
  { name: 'Cookbook', description: 'Healthy recipes', price: 24.99, categories: ['Books', 'Home'] },
  { name: 'Board Game', description: 'Strategy board game', price: 29.99, categories: ['Toys', 'Home'] },
  { name: 'Electric Kettle', description: '1.7L electric kettle', price: 39.99, categories: ['Home', 'Electronics'] },
  { name: 'Garden Hose', description: 'Expandable garden hose', price: 25.99, categories: ['Home', 'Garden'] },
  { name: 'Car Vacuum Cleaner', description: 'Portable car vacuum cleaner', price: 45.99, categories: ['Home', 'Automotive'] },
  { name: 'Face Cream', description: 'Moisturizing face cream', price: 15.99, categories: ['Beauty', 'Health'] },
  { name: 'Yoga Mat', description: 'Non-slip yoga mat', price: 29.99, categories: ['Sports', 'Health'] },
  { name: 'Vitamin Supplements', description: 'Multivitamin tablets', price: 14.99, categories: ['Health', 'Home'] },
  { name: 'LED Light Bulb', description: 'Energy-saving LED bulb', price: 9.99, categories: ['Home', 'Electronics'] },
  { name: 'Running Shoes', description: 'Breathable running shoes', price: 59.99, categories: ['Sports', 'Clothing'] },
  { name: 'Wireless Mouse', description: 'Ergonomic wireless mouse', price: 25.99, categories: ['Electronics', 'Home'] },
  { name: 'Tablet', description: '10-inch tablet', price: 299.99, categories: ['Electronics', 'Home'] }
]

products.each do |product_data|
  product = Product.where(name: product_data[:name]).first ||
            Product.create!(
              name: product_data[:name],
              description: product_data[:description],
              price: product_data[:price],
              admin_id: Admin.first.id
            )

  product_data[:categories].each do |category_name|
    category = Category.where(name: category_name).first
    Categorization.where(product_id: product.id, category_id: category.id).first ||
      Categorization.create!(product_id: product.id, category_id: category.id)
  end
end

# Create customers
customer_names = ['John Doe', 'Jane Roe', 'Alice Johnson', 'Michael Scott', 'Pam Beesly', 'Jim Halpert', 'Dwight Schrute', 'Angela Martin', 'Oscar Martinez', 'Kevin Malone', 'Stanley Hudson', 'Phyllis Vance', 'Andy Bernard']
customer_emails = ['john@example.com', 'jane@example.com', 'alicej@example.com', 'michael@example.com', 'pam@example.com', 'jim@example.com', 'dwight@example.com', 'angela@example.com', 'oscar@example.com', 'kevin@example.com']

customer_names.each_with_index do |name, index|
  Customer.where(name: name).first ||
    Customer.create!(name: name, email: customer_emails[index])
end

# Sales data for today and yesterday
sales_data = [
  { product_name: 'Smartphone', customer_name: 'John Doe', quantity: 2, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 9, 0, 0) },
  { product_name: 'Laptop', customer_name: 'Jane Roe', quantity: 1, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 9, 15, 0) },
  { product_name: 'Wireless Headphones', customer_name: 'Michael Scott', quantity: 3, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 9, 30, 0) },
  { product_name: 'Smartwatch', customer_name: 'Pam Beesly', quantity: 1, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 9, 45, 0) },
  { product_name: 'Bluetooth Speaker', customer_name: 'Jim Halpert', quantity: 4, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 10, 0, 0) },
  { product_name: 'T-Shirt', customer_name: 'John Doe', quantity: 5, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 10, 15, 0) },
  { product_name: 'Jeans', customer_name: 'Jane Roe', quantity: 2, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 10, 30, 0) },
  { product_name: 'Fiction Novel', customer_name: 'Michael Scott', quantity: 1, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 10, 45, 0) },
  { product_name: 'Cookbook', customer_name: 'Pam Beesly', quantity: 2, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 11, 0, 0) },
  { product_name: 'Board Game', customer_name: 'Jim Halpert', quantity: 3, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 11, 15, 0) },
  { product_name: 'Electric Kettle', customer_name: 'John Doe', quantity: 1, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 11, 30, 0) },
  { product_name: 'Garden Hose', customer_name: 'Jane Roe', quantity: 1, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 11, 45, 0) },
  { product_name: 'Car Vacuum Cleaner', customer_name: 'Michael Scott', quantity: 2, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 12, 0, 0) },
  { product_name: 'Face Cream', customer_name: 'Pam Beesly', quantity: 5, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 12, 15, 0) },
  { product_name: 'Yoga Mat', customer_name: 'Jim Halpert', quantity: 4, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 12, 30, 0) },
  { product_name: 'Vitamin Supplements', customer_name: 'John Doe', quantity: 3, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 12, 45, 0) },
  { product_name: 'LED Light Bulb', customer_name: 'Jane Roe', quantity: 6, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 13, 0, 0) },
  { product_name: 'Running Shoes', customer_name: 'Michael Scott', quantity: 2, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 13, 15, 0) },
  { product_name: 'Wireless Mouse', customer_name: 'Pam Beesly', quantity: 1, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 13, 30, 0) },
  { product_name: 'Tablet', customer_name: 'Jim Halpert', quantity: 1, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 13, 45, 0) },
  { product_name: 'Smartphone', customer_name: 'Jim Halpert', quantity: 2, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 14, 0, 0) },
  { product_name: 'Laptop', customer_name: 'Pam Beesly', quantity: 1, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 14, 15, 0) },
  { product_name: 'Smartphone', customer_name: 'Stanley Hudson', quantity: 1, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 14, 30, 0) },
  { product_name: 'Laptop', customer_name: 'Phyllis Vance', quantity: 1, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 14, 45, 0) },
  { product_name: 'Wireless Headphones', customer_name: 'Andy Bernard', quantity: 2, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 15, 0, 0) },
  { product_name: 'Smartwatch', customer_name: 'Michael Scott', quantity: 1, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 15, 15, 0) },
  { product_name: 'Bluetooth Speaker', customer_name: 'Phyllis Vance', quantity: 3, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 15, 30, 0) },
  { product_name: 'T-Shirt', customer_name: 'Andy Bernard', quantity: 4, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 15, 45, 0) },
  { product_name: 'Jeans', customer_name: 'Stanley Hudson', quantity: 2, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 16, 0, 0) },
  { product_name: 'Fiction Novel', customer_name: 'Phyllis Vance', quantity: 1, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 16, 15, 0) },
  { product_name: 'Cookbook', customer_name: 'Andy Bernard', quantity: 2, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 16, 30, 0) },
  { product_name: 'Board Game', customer_name: 'Michael Scott', quantity: 3, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 16, 45, 0) },
  { product_name: 'Electric Kettle', customer_name: 'Phyllis Vance', quantity: 1, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 17, 0, 0) },
  { product_name: 'Garden Hose', customer_name: 'Andy Bernard', quantity: 1, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 17, 15, 0) },
  { product_name: 'Car Vacuum Cleaner', customer_name: 'Stanley Hudson', quantity: 2, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 17, 30, 0) },
  { product_name: 'Face Cream', customer_name: 'Phyllis Vance', quantity: 5, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 17, 45, 0) },
  { product_name: 'Yoga Mat', customer_name: 'Jim Halpert', quantity: 4, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 18, 0, 0) },
  { product_name: 'Vitamin Supplements', customer_name: 'Stanley Hudson', quantity: 3, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 18, 15, 0) },
  { product_name: 'LED Light Bulb', customer_name: 'Phyllis Vance', quantity: 6, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 18, 30, 0) },
  { product_name: 'Running Shoes', customer_name: 'Andy Bernard', quantity: 2, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 18, 45, 0) },
  { product_name: 'Wireless Mouse', customer_name: 'Michael Scott', quantity: 1, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 19, 0, 0) },
  { product_name: 'Tablet', customer_name: 'Phyllis Vance', quantity: 1, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 19, 15, 0) },
  { product_name: 'Smartphone', customer_name: 'Jim Halpert', quantity: 2, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 19, 30, 0) },
  { product_name: 'Laptop', customer_name: 'Stanley Hudson', quantity: 1, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 19, 45, 0) },
  { product_name: 'Wireless Headphones', customer_name: 'Michael Scott', quantity: 2, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 20, 0, 0) },
  { product_name: 'Smartwatch', customer_name: 'Andy Bernard', quantity: 1, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 20, 15, 0) },
  { product_name: 'Bluetooth Speaker', customer_name: 'Stanley Hudson', quantity: 3, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 20, 30, 0) },
  { product_name: 'T-Shirt', customer_name: 'Phyllis Vance', quantity: 4, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 20, 45, 0) },
  { product_name: 'Jeans', customer_name: 'Andy Bernard', quantity: 2, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 21, 0, 0) },
  { product_name: 'Fiction Novel', customer_name: 'Stanley Hudson', quantity: 1, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 21, 15, 0) },
  { product_name: 'Cookbook', customer_name: 'Michael Scott', quantity: 2, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 21, 30, 0) },
  { product_name: 'Board Game', customer_name: 'Andy Bernard', quantity: 3, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 21, 45, 0) },
  { product_name: 'Electric Kettle', customer_name: 'Stanley Hudson', quantity: 1, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 22, 0, 0) },
  { product_name: 'Garden Hose', customer_name: 'Jim Halpert', quantity: 1, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 22, 15, 0) },
  { product_name: 'Car Vacuum Cleaner', customer_name: 'Andy Bernard', quantity: 2, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 22, 30, 0) },
  { product_name: 'Face Cream', customer_name: 'Pam Beesly', quantity: 5, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 22, 45, 0) },
  { product_name: 'Yoga Mat', customer_name: 'Phyllis Vance', quantity: 4, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 23, 0, 0) },
  { product_name: 'Vitamin Supplements', customer_name: 'Andy Bernard', quantity: 3, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 23, 15, 0) },
  { product_name: 'LED Light Bulb', customer_name: 'Stanley Hudson', quantity: 6, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 23, 30, 0) },
  { product_name: 'Running Shoes', customer_name: 'Jim Halpert', quantity: 2, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 23, 45, 0) },
  { product_name: 'Wireless Mouse', customer_name: 'Andy Bernard', quantity: 1, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 0, 0, 0) },
  { product_name: 'Tablet', customer_name: 'Stanley Hudson', quantity: 1, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 0, 15, 0) },
  { product_name: 'Smartphone', customer_name: 'Phyllis Vance', quantity: 2, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 0, 30, 0) },
  { product_name: 'Laptop', customer_name: 'Andy Bernard', quantity: 1, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 0, 45, 0) },
  { product_name: 'Wireless Headphones', customer_name: 'Pam Beesly', quantity: 2, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 1, 0, 0) },
  { product_name: 'Smartwatch', customer_name: 'Phyllis Vance', quantity: 1, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 1, 15, 0) },
  { product_name: 'Bluetooth Speaker', customer_name: 'Andy Bernard', quantity: 3, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 1, 30, 0) },
  { product_name: 'T-Shirt', customer_name: 'Stanley Hudson', quantity: 4, created_at: Time.new(Date.today.year, Date.today.month, Date.today.day, 1, 45, 0) },
  { product_name: 'Smartphone', customer_name: 'Angela Martin', quantity: 1, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 9, 0, 0) },
  { product_name: 'Cookbook', customer_name: 'Kevin Malone', quantity: 1, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 9, 15, 0) },
  { product_name: 'Board Game', customer_name: 'Oscar Martinez', quantity: 2, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 9, 30, 0) },
  { product_name: 'Laptop', customer_name: 'Dwight Schrute', quantity: 1, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 9, 45, 0) },
  { product_name: 'Tablet', customer_name: 'Angela Martin', quantity: 2, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 10, 0, 0) },
  { product_name: 'Smartwatch', customer_name: 'Kevin Malone', quantity: 1, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 10, 15, 0) },
  { product_name: 'LED Light Bulb', customer_name: 'Oscar Martinez', quantity: 4, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 10, 30, 0) },
  { product_name: 'Wireless Headphones', customer_name: 'Dwight Schrute', quantity: 3, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 10, 45, 0) },
  { product_name: 'T-Shirt', customer_name: 'Angela Martin', quantity: 2, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 11, 0, 0) },
  { product_name: 'Running Shoes', customer_name: 'Kevin Malone', quantity: 2, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 11, 15, 0) },
  { product_name: 'Smartphone', customer_name: 'John Doe', quantity: 1, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 11, 30, 0) },
  { product_name: 'Laptop', customer_name: 'Jane Roe', quantity: 1, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 11, 45, 0) },
  { product_name: 'Wireless Headphones', customer_name: 'Alice Johnson', quantity: 2, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 12, 0, 0) },
  { product_name: 'Smartwatch', customer_name: 'Michael Scott', quantity: 1, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 12, 15, 0) },
  { product_name: 'Bluetooth Speaker', customer_name: 'Pam Beesly', quantity: 3, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 12, 30, 0) },
  { product_name: 'T-Shirt', customer_name: 'Jim Halpert', quantity: 4, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 12, 45, 0) },
  { product_name: 'Jeans', customer_name: 'Dwight Schrute', quantity: 2, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 13, 0, 0) },
  { product_name: 'Fiction Novel', customer_name: 'Angela Martin', quantity: 1, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 13, 15, 0) },
  { product_name: 'Cookbook', customer_name: 'Oscar Martinez', quantity: 2, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 13, 30, 0) },
  { product_name: 'Board Game', customer_name: 'Kevin Malone', quantity: 3, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 13, 45, 0) },
  { product_name: 'Electric Kettle', customer_name: 'John Doe', quantity: 1, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 14, 0, 0) },
  { product_name: 'Garden Hose', customer_name: 'Jane Roe', quantity: 1, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 14, 15, 0) },
  { product_name: 'Car Vacuum Cleaner', customer_name: 'Alice Johnson', quantity: 2, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 14, 30, 0) },
  { product_name: 'Face Cream', customer_name: 'Michael Scott', quantity: 5, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 14, 45, 0) },
  { product_name: 'Yoga Mat', customer_name: 'Pam Beesly', quantity: 4, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 15, 0, 0) },
  { product_name: 'Vitamin Supplements', customer_name: 'Jim Halpert', quantity: 3, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 15, 15, 0) },
  { product_name: 'LED Light Bulb', customer_name: 'Dwight Schrute', quantity: 6, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 15, 30, 0) },
  { product_name: 'Running Shoes', customer_name: 'Angela Martin', quantity: 2, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 15, 45, 0) },
  { product_name: 'Wireless Mouse', customer_name: 'Oscar Martinez', quantity: 1, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 16, 0, 0) },
  { product_name: 'Tablet', customer_name: 'Kevin Malone', quantity: 1, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 16, 15, 0) },
  { product_name: 'Smartphone', customer_name: 'John Doe', quantity: 2, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 16, 30, 0) },
  { product_name: 'Laptop', customer_name: 'Jane Roe', quantity: 1, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 16, 45, 0) },
  { product_name: 'Wireless Headphones', customer_name: 'Alice Johnson', quantity: 2, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 17, 0, 0) },
  { product_name: 'Smartwatch', customer_name: 'Michael Scott', quantity: 1, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 17, 15, 0) },
  { product_name: 'Bluetooth Speaker', customer_name: 'Pam Beesly', quantity: 3, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 17, 30, 0) },
  { product_name: 'T-Shirt', customer_name: 'Jim Halpert', quantity: 4, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 17, 45, 0) },
  { product_name: 'Jeans', customer_name: 'Dwight Schrute', quantity: 2, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 18, 0, 0) },
  { product_name: 'Fiction Novel', customer_name: 'Angela Martin', quantity: 1, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 18, 15, 0) },
  { product_name: 'Cookbook', customer_name: 'Oscar Martinez', quantity: 2, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 18, 30, 0) },
  { product_name: 'Board Game', customer_name: 'Kevin Malone', quantity: 3, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 18, 45, 0) },
  { product_name: 'Electric Kettle', customer_name: 'John Doe', quantity: 1, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 19, 0, 0) },
  { product_name: 'Garden Hose', customer_name: 'Jane Roe', quantity: 1, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 19, 15, 0) },
  { product_name: 'Car Vacuum Cleaner', customer_name: 'Alice Johnson', quantity: 2, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 19, 30, 0) },
  { product_name: 'Face Cream', customer_name: 'Michael Scott', quantity: 5, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 19, 45, 0) },
  { product_name: 'Yoga Mat', customer_name: 'Pam Beesly', quantity: 4, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 20, 0, 0) },
  { product_name: 'Vitamin Supplements', customer_name: 'Jim Halpert', quantity: 3, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 20, 15, 0) },
  { product_name: 'LED Light Bulb', customer_name: 'Dwight Schrute', quantity: 6, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 20, 30, 0) },
  { product_name: 'Running Shoes', customer_name: 'Angela Martin', quantity: 2, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 20, 45, 0) },
  { product_name: 'Wireless Mouse', customer_name: 'Oscar Martinez', quantity: 1, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 21, 0, 0) },
  { product_name: 'Tablet', customer_name: 'Kevin Malone', quantity: 1, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 21, 15, 0) },
  { product_name: 'Smartphone', customer_name: 'John Doe', quantity: 2, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 21, 30, 0) },
  { product_name: 'Laptop', customer_name: 'Jane Roe', quantity: 1, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 21, 45, 0) },
  { product_name: 'Wireless Headphones', customer_name: 'Alice Johnson', quantity: 2, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 22, 0, 0) },
  { product_name: 'Smartwatch', customer_name: 'Michael Scott', quantity: 1, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 22, 15, 0) },
  { product_name: 'Bluetooth Speaker', customer_name: 'Pam Beesly', quantity: 3, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 22, 30, 0) },
  { product_name: 'T-Shirt', customer_name: 'Jim Halpert', quantity: 4, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 22, 45, 0) },
  { product_name: 'Jeans', customer_name: 'Dwight Schrute', quantity: 2, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 23, 0, 0) },
  { product_name: 'Fiction Novel', customer_name: 'Angela Martin', quantity: 1, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 23, 15, 0) },
  { product_name: 'Cookbook', customer_name: 'Oscar Martinez', quantity: 2, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 23, 30, 0) },
  { product_name: 'Board Game', customer_name: 'Kevin Malone', quantity: 3, created_at: Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 23, 45, 0) }
]

# Create purchases

sales_data.each do |sale|
  product = Product.where(name: sale[:product_name]).first
  customer = Customer.where(name: sale[:customer_name]).first
  total_price = product.price * sale[:quantity]

  Purchase.where(
    product_id: product.id,
    customer_id: customer.id,
    created_at: sale[:created_at]
  ).first ||
  Purchase.create!(
    product_id: product.id,
    customer_id: customer.id,
    quantity: sale[:quantity],
    total_price: total_price,
    created_at: sale[:created_at]
  )
end

product_images_data = [
  { url: 'https://example.com/images/smartphone.jpg', imageable_type: 'Product' },
  { url: 'https://example.com/images/laptop.jpg', imageable_type: 'Product' },
  { url: 'https://example.com/images/headphones.jpg', imageable_type: 'Product' },
  { url: 'https://example.com/images/smartwatch.jpg', imageable_type: 'Product' },
  { url: 'https://example.com/images/speaker.jpg', imageable_type: 'Product' },
  { url: 'https://example.com/images/tshirt.jpg', imageable_type: 'Product' },
  { url: 'https://example.com/images/jeans.jpg', imageable_type: 'Product' },
  { url: 'https://example.com/images/novel.jpg', imageable_type: 'Product' },
  { url: 'https://example.com/images/cookbook.jpg', imageable_type: 'Product' },
  { url: 'https://example.com/images/boardgame.jpg', imageable_type: 'Product' },
  { url: 'https://example.com/images/kettle.jpg', imageable_type: 'Product' },
  { url: 'https://example.com/images/hose.jpg', imageable_type: 'Product' },
  { url: 'https://example.com/images/car_vacuum.jpg', imageable_type: 'Product' },
  { url: 'https://example.com/images/face_cream.jpg', imageable_type: 'Product' },
  { url: 'https://example.com/images/yoga_mat.jpg', imageable_type: 'Product' },
  { url: 'https://example.com/images/vitamins.jpg', imageable_type: 'Product' },
  { url: 'https://example.com/images/led_bulb.jpg', imageable_type: 'Product' },
  { url: 'https://example.com/images/shoes.jpg', imageable_type: 'Product' },
  { url: 'https://example.com/images/mouse.jpg', imageable_type: 'Product' },
  { url: 'https://example.com/images/tablet.jpg', imageable_type: 'Product' }
]

product_images_data.each do |image|
  product = Product.all.sample
  ProductImage.create!(
    url: image[:url],
    imageable_type: image[:imageable_type],
    imageable_id: product.id
  )
end