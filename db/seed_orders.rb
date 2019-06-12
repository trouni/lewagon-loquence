require 'csv'
require 'faker'

def salt_amount(amount)
  (amount / 5.0).round
end

def fake_food_product_name
  [
    "#{Faker::Food.ingredient} " + ["Cookie", "Biscuit", "Protein Bar"].sample,
    "#{Faker::Food.fruits} & #{Faker::Food.spice} " + ["Cookie", "Biscuit", "Protein Bar", "Caviar", "Terrine", "Jerky", "Granola Bar"].sample,
    %w[Dried Sundried].sample + " #{Faker::Food.sushi}",
    "#{Faker::Food.vegetables} " + ["Cookie", "Biscuit", "Protein Bar", "Caviar", "Terrine", "Jerky", "Granola Bar"].sample
  ].sample.split(" ").map { |word| word.capitalize }.join(" ")
end

def destroy_order_seeds
  puts "Destroying order items..."
  OrderItem.all.destroy_all
  puts "Destroying orders..."
  Order.all.destroy_all
  puts "Destroying products..."
  Product.all.destroy_all
  puts "Destroying buyers..."
  Buyer.all.destroy_all
end

def seed_orders
  count = 0
  filepath = 'db/seed_data/amazon_seeds.csv'
  puts "Loading #{filepath}..."

  @order_items = CSV.read(filepath, col_sep: ',', header_converters: :symbol, encoding: "utf-8", headers: :first_row, quote_char: '"')

  time_offset = 192 # offsetting purchase date by X days in orders

  puts "Date of the last order in the DB: #{(Order.order(purchase_date: :asc).last || {purchase_date: "No orders in the database."} )[:purchase_date]}"
  puts "Importing seeds for buyers, products, orders and order items since #{(Order.order(purchase_date: :asc).last || {purchase_date: DateTime.parse("2000-01-01")})[:purchase_date]}..."
  @order_items.each do |order_item|
    if order_item[:orderstatus] != "Canceled" && order_item[:orderstatus] != "Pending" && DateTime.parse(order_item[:purchasedate]) + time_offset <= DateTime.now && DateTime.parse(order_item[:purchasedate]) + time_offset > (Order.order(purchase_date: :asc).last || {purchase_date: DateTime.parse("2000-01-01")})[:purchase_date]

      buyer = Buyer.find_by(email: order_item[:buyeremail]) || Buyer.create!(email: order_item[:buyeremail])
      # print "."

      order_hash = {
        buyer: buyer,
        external_source: order_item[:saleschannel],
        external_order_id: order_item[:amazonorderid],
        purchase_date: DateTime.parse(order_item[:purchasedate]) + time_offset,
        order_status: order_item[:orderstatus],
        shipping_address_region: order_item[:shippingaddress_stateorregion],
        shipping_address_country_code: order_item[:shippingaddress_countrycode],
        order_total_cents: (salt_amount(order_item[:ordertotal].gsub(/[a-zA-Z]/,"").to_f) * 100.0).to_i,
        currency: order_item[:ordertotal].first(3),
        items_total: order_item[:numberofitemsshipped] + order_item[:numberofitemsunshipped]
      }

      order = Order.find_by(external_order_id: order_item[:amazonorderid]) || Order.create!(order_hash)
      # print "."

      product = Product.find_by(sku: "BESTIES-#{order_item[:lsku]}") || Product.create!(sku: "BESTIES-#{order_item[:lsku]}", title: fake_food_product_name)
      # print "."

      if order_item[:itemprice]
        item_price_cents = (salt_amount(order_item[:itemprice].gsub(/[a-zA-Z]/,"").to_f) * 100.0).to_i
        currency = order_item[:itemprice].first(3)
      end

      OrderItem.create!(
        order: order,
        product: product,
        item_price_cents: item_price_cents,
        external_order_item_id: order_item[:orderitemid],
        quantity: order_item[:quantityordered],
        currency: currency
      )
      count += 1
      print "."
    end
  end
  puts
  puts "Imported #{count} order items into the DB."
end
