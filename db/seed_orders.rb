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

def destroy_order_seeds(platform = nil)
  # puts "Destroying order items..."
  # OrderItem.where(external_source: platform).destroy_all
  puts "Destroying orders..."
  platform ? Order.where(external_source: platform).destroy_all : Order.destroy_all
end
  # puts "Destroying products..."
  # Product.all.destroy_all
  # puts "Destroying buyers..."
  # Buyer.all.destroy_all

def seed_order_item(order_item, time_offset)
  buyer = Buyer.find_by(email: order_item[:buyeremail]) || Buyer.create!(email: order_item[:buyeremail])

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

  product = Product.find_by(sku: "BESTIES-#{order_item[:lsku]}") || Product.create!(sku: "BESTIES-#{order_item[:lsku]}", title: fake_food_product_name)

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
  print "."
end

def probability_over_time(current_time, start_time, end_time)
  probability = ((current_time - start_time) / (end_time - start_time)) * 100.0
  return rand(101) <= probability * 1.5
end

def seed_amazon_orders
  filepath = 'db/seed_data/amazon_seeds.csv'
  puts "Loading #{filepath}..."
  @order_items = CSV.read(filepath, col_sep: ',', header_converters: :symbol, encoding: "utf-8", headers: :first_row, quote_char: '"')

  time_offset = 192 # offsetting purchase date by X days in orders

  start_time = DateTime.parse(@order_items[0][:purchasedate]) + time_offset
  end_time = DateTime.parse(@order_items[0][:purchasedate]) + time_offset + 100
  count = 0
  @order_items.each do |order_item|
    purchase_date = DateTime.parse(order_item[:purchasedate])
    if order_item[:orderstatus] != "Canceled" && order_item[:orderstatus] != "Pending" && DateTime.parse(order_item[:purchasedate]) + time_offset <= DateTime.parse("2019-06-14T19:30:00+00:00")
      if Order.find_by(external_order_id: order_item[:amazonorderid])
        count += 1
        seed_order_item(order_item, time_offset)
      else
        if probability_over_time(purchase_date + time_offset, start_time, end_time)
          seed_order_item(order_item, time_offset)
          count += 1
        end
      end
    end
  end
  puts
  puts "#{count} Amazon orders were seeded into the DB."
end

def seed_shopify_orders
  filepath = 'db/seed_data/shopify_seeds.csv'
  puts "Loading #{filepath}..."
  line_count = 6161
  puts line_count

  @order_items = CSV.read(filepath, col_sep: ',', header_converters: :symbol, encoding: "utf-8", headers: :first_row, quote_char: '"')
  time_offset = 169 # offsetting purchase date by X days in orders

  start_time = DateTime.parse(@order_items[0][:purchasedate]) + time_offset
  end_time = DateTime.now - 10
  count = 0
  @order_items.each do |order_item|
    purchase_date = DateTime.parse(order_item[:purchasedate])
    if order_item[:orderstatus] != "Canceled" && order_item[:orderstatus] != "Pending" && DateTime.parse(order_item[:purchasedate]) + time_offset <= DateTime.parse("2019-06-14T19:30:00+00:00")
      if Order.find_by(external_order_id: order_item[:amazonorderid])
        count += 1
        seed_order_item(order_item, time_offset)
      else
        if probability_over_time(purchase_date + time_offset, start_time, end_time)
          seed_order_item(order_item, time_offset)
          count += 1
        end
      end
    end
  end
  puts
  puts "#{count} Shopify orders were seeded into the DB."
end

