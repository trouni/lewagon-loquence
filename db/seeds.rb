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
puts ""

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
puts ""

puts "creating reports..."

monthly_sales_report =
  Report.create!(
    name: 'Monthly sales',
    description: 'Monitoring monthly sales',
  )

sales_widget =
  Widget.create!(
    report: monthly_sales_report,
    name: 'Evolution of sales per week',
    display_type: 'line_chart',
    kpi: KPI.create!(
      partial_name: 'revenue_per_week'
      )
    )

customers_widget =
  Widget.create!(
    report: monthly_sales_report,
    name: 'repeat customers',
    display_type: 'column_chart',
    kpi:  KPI.create!(
        partial_name: 'repeat_customers'
      )
    )

 order_analysis_report =
  Report.create!(
    name: 'Order analysis',
    description: 'Analyze orders',
  )

quantity_widget =
  Widget.create!(
    report: order_analysis_report,
    name: 'Average quantity per product',
    display_type: 'pie_chart',
    kpi: KPI.create!(
        partial_name: 'avg_qty_per_product'
      )
   )

amout_order_widget =
  Widget.create!(
    report: order_analysis_report,
    name: 'Average amount per order',
    display_type: 'line_chart',
    kpi: KPI.create!(
      partial_name: 'avg_order_amount_and_items'
    )
  )


