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

def seed_orders
  puts "Destroying order items..."
  OrderItem.all.destroy_all
  puts "Destroying orders..."
  Order.all.destroy_all
  puts "Destroying products..."
  Product.all.destroy_all
  puts "Destroying buyers..."
  Buyer.all.destroy_all

  filepath = 'db/seed_data/amazon_seeds.csv'
  puts "Loading #{filepath}..."

  @orders = CSV.read(filepath, col_sep: ',', header_converters: :symbol, encoding: "utf-8", headers: :first_row, quote_char: '"')

  time_offset = 192 # offsetting dates in orders

  puts "Creating seeds..."
  @orders.each do |order|
    if order[:orderstatus] != "Canceled" && order[:orderstatus] != "Pending"
      buyer = Buyer.find_by(email: order[:buyeremail]) || Buyer.create!(email: order[:buyeremail])
      print "#"

      order_hash = {
        buyer: buyer,
        external_source: order[:saleschannel],
        external_order_id: order[:amazonorderid],
        purchase_date: DateTime.parse(order[:purchasedate]) + time_offset,
        order_status: order[:orderstatus],
        shipping_address_region: order[:shippingaddress_stateorregion],
        shipping_address_country_code: order[:shippingaddress_countrycode],
        order_total_cents: (salt_amount(order[:ordertotal].gsub(/[a-zA-Z]/,"").to_f) * 100.0).to_i,
        currency: order[:ordertotal].first(3),
        items_total: order[:numberofitemsshipped] + order[:numberofitemsunshipped]
      }

      order = Order.find_by(external_order_id: order[:amazonorderid]) || Order.create!(order_hash)
      print "#"

      product = Product.find_by(sku: "BESTIES-#{order[:lsku]}") || Product.create!(sku: "BESTIES-#{order[:lsku]}", title: fake_food_product_name)
      print "#"

      if order[:itemprice]
        item_price_cents = (salt_amount(order[:itemprice].gsub(/[a-zA-Z]/,"").to_f) * 100.0).to_i
        currency = order[:itemprice].first(3)
      end

      OrderItem.create!(
        order: order,
        product: product,
        item_price_cents: item_price_cents,
        external_order_item_id: order[:orderitemid],
        quantity: order[:quantityordered],
        currency: currency
      )
      print "#"
    end
  end
  puts
end
