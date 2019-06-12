COMPANIES = [
  {
    name: "Loquence"
  }
]

USERS = [
  {
    email: "trouni@loquence.co",
    password: "secret"
  },
  {
    email: "saad@loquence.co",
    password: "secret"
  },
  {
    email: "alex@loquence.co",
    password: "secret"
  },
  {
    email: "eugene@loquence.co",
    password: "secret"
  },
]

SAMPLE_REPORT_LAYOUTS = {
    "Monthly sales": {
      layout: [
        "1 / 1 / span 4 / span 4",
        "1 / 5 / span 4 / span 4",
        "1 / 9 / span 3 / span 4",
        "4 / 9 / span 6 / span 4",
        "5 / 6 / span 4 / span 3",
        "5 / 1 / span 4 / span 5",
        "9 / 1 / span 3 / span 8"
      ],
      kpis: []
    },
    "Customers report": {
      layout: [
        "1 / 1 / span 5 / span 4",
        "1 / 5 / span 5 / span 4",
        "1 / 9 / span 5 / span 4",
        "6 / 1 / span 5 / span 12"
      ],
      kpis: []
    },
    "Daily report": {
      layout: [
        "1 / 1 / span 3 / span 4",
        "1 / 5 / span 4 / span 8",
        "4 / 1 / span 4 / span 4",
        "5 / 9 / span 5 / span 4",
        "8 / 1 / span 3 / span 4"
        "5 / 5 / span 5 / span 4",
      ],
      kpis: [
        "unique_customers",
        "revenue",
        "repeat_customers",
        "revenue_this_month",
        "avg_customer_value"
        "customers_per_country",
      ]
    }
  }

if ENV["orders"]
  require 'yaml'
  puts "Destroying order items..."
  OrderItem.all.destroy_all
  puts "Destroying orders..."
  Order.all.destroy_all
  puts "Destroying products..."
  Product.all.destroy_all
  puts "Destroying buyers..."
  Buyer.all.destroy_all

  puts "Loading amazon_orders.yml..."
  amazon_orders = YAML.load(File.open('db/seed_data/amazon_orders.yml'))

  puts "Creating buyers and orders..."
  amazon_orders.each do |order|
    if order["OrderStatus"] != "Canceled" && order["OrderStatus"] != "Pending"
      buyer = Buyer.find_by(email: order["BuyerEmail"]) || Buyer.create!(email: order["BuyerEmail"])

      Order.create!(
        buyer: buyer,
        external_source: "amazon",
        external_order_id: order["AmazonOrderId"],
        purchase_date: order["PurchaseDate"],
        order_status: order["OrderStatus"],
        shipping_address_region: order["ShippingAddress_StateOrRegion"],
        shipping_address_country_code: order["ShippingAddress_CountryCode"],
        order_total_cents: (order["OrderTotal"].gsub(/[a-zA-Z]/,"").to_f * 100).to_i,
        currency: order["OrderTotal"].first(3),
        items_total: order["NumberOfItemsShipped"] + order["NumberOfItemsUnshipped"]
      )
      print "#"
    end
  end
  puts

  puts "Loading amazon_order_items.yml..."
  amazon_order_items = YAML.load(File.open('db/seed_data/amazon_order_items.yml'))

  puts "Creating products and order items..."
  amazon_order_items.each do |order_item|
    if order_item["OrderStatus"] != "Canceled" && order_item["OrderStatus"] != "Pending"
      order = Order.find_by(external_order_id: order_item["AmazonOrderId"])
      product = Product.find_by(sku: order_item["SellerSKU"]) || Product.create!(sku: order_item["SellerSKU"], title: order_item["Title"])

      if order_item["ItemPrice"]
        item_price_cents = (order_item["ItemPrice"].gsub(/[a-zA-Z]/,"").to_f * 100).to_i
        currency = order_item["ItemPrice"].first(3)
      end
      OrderItem.create!(
        order: order,
        product: product,
        item_price_cents: item_price_cents,
        external_order_item_id: order_item["OrderItemId"],
        quantity: order_item["QuantityOrdered"],
        currency: currency
      )
      print "#"
    end
  end
  puts
end


puts "Destroying reports..."
Report.all.destroy_all
puts "Destroying users..."
ActiveRecord::Base.connection.execute "truncate users cascade"
puts "Destroying companies..."
Company.all.destroy_all
puts "Destroying KPIs..."
KPI.all.destroy_all


puts "Creating companies & users..."

USERS.each do |user|
  user = User.create!(email: user[:email], password: user[:password])
end

COMPANIES.each do |company|
  Company.create!(name: company[:name], owner: User.first)
end


puts "Creating KPIs..."
KPI_NAMES = Dir["./app/views/kpis/*"].map { |filepath| filepath.gsub("./app/views/kpis/_","").gsub(".html.erb","")}

KPI_NAMES.each do |kpi|
  KPI.create!(
    query: kpi,
    name: kpi.gsub("_"," ").capitalize
  )
end

puts "Creating reports and widgets..."

User.all.each do |user|
  user.update(company: Company.last)

  # grid-area: grid-row-start / grid-column-start / grid-row-end / grid-column-end | itemname;


  SAMPLE_REPORT_LAYOUTS.each do |title, widget|
    report =
      Report.create!(
        name: title,
        description: "Description of #{title}",
        owner: user
      )
    print "#"
    widget[:layout].each_with_index do |widget_layout, index|
      kpi_name = widget[:kpis][index] || KPI_NAMES.sample
      Widget.create!(
        report: report,
        name: kpi_name.gsub("_"," ").capitalize,
        grid_item_position: widget_layout,
        kpi: KPI.find_by(query: kpi_name)
      )
      print "#"
    end
    print "#"
  end
  puts
end
