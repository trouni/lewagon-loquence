require_relative 'seed_orders'

COMPANIES = [
  {
    name: "Besties Natural",
    remote_photo_url: "http://www.bestiesnatural.com/wp-content/uploads/2019/02/besties_logo_blue_1000px.png"
  }
]

GROUPS = [
  {name: "IT"},
  {name: "Marketing"},
  {name: "Logistics"},
  {name: "Customer Support"}
]

USERS = [
  {
    first_name: "Trouni",
    last_name: "Tiet",
    email: "trouni@loquence.co",
    password: "secret",
    remote_photo_url: "https://avatars3.githubusercontent.com/u/34345789?v=4"
  },
  {
    first_name: "Saad",
    last_name: "Amrani",
    email: "saad@loquence.co",
    password: "secret",
    remote_photo_url: "https://avatars0.githubusercontent.com/u/21337523?v=4"
  },
  {
    first_name: "Eugene",
    last_name: "Sia",
    email: "eugene@loquence.co",
    password: "secret",
    remote_photo_url: "https://avatars1.githubusercontent.com/u/49116295?v=4"
  },
  {
    first_name: "Alex",
    last_name: "Remp",
    email: "alex@loquence.co",
    password: "secret",
    remote_photo_url: "https://avatars0.githubusercontent.com/u/48198772?v=4"
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
      "1 / 1 / span 6 / span 4",
      "1 / 5 / span 5 / span 8",
      "7 / 1 / span 7 / span 4",
      "6 / 9 / span 7 / span 4",
      "11 / 5 / span 5 / span 4",
      "6 / 5 / span 5 / span 4"
    ],
    kpis: [
      "unique_customers",
      "revenue",
      "repeat_customers",
      "revenue_this_month",
      "avg_customer_value",
      "customers_per_country"
    ]
  }
}


puts "Destroying reports..."
Report.all.destroy_all
puts "Destroying users..."
ActiveRecord::Base.connection.execute "truncate users cascade"
puts "Destroying companies..."
Company.all.destroy_all
puts "Destroying KPIs..."
KPI.all.destroy_all
puts "Destroying groups..."
Group.all.destroy_all


puts "Creating KPIs..."

KPI::KPI_NAMES.each do |kpi|
  KPI.create!(
    query: kpi,
    name: kpi.gsub("_"," ").capitalize
  )
end

puts "Creating companies & users..."
USERS.each do |attrs|
  # user = User.create!(first_name: user[:first_name], last_name: user[:last_name], email: user[:email], password: user[:password]) #cancelled out by Forest
  user = User.create!(attrs)
end

COMPANIES.each do |company|
  company_one = Company.new(name: company[:name], owner: User.first)
  company_one.remote_photo_url = company[:remote_photo_url]
  company_one.save
end


GROUPS.each do |group|
  group = Group.create!(name: group[:name])
  rand(1...5).times do
    GroupUser.create(user: User.all.sample, group: group)
  end
end

puts
puts "Creating reports and widgets..."

User.all.each do |user|
  user.update(company: Company.last)

  # grid-area: grid-row-start / grid-column-start / grid-row-end / grid-column-end | itemname;
  if user != User.first
    report = Report.create!(
      name: "#{user.first_name.capitalize}'s Personal KPIs",
      owner: user
    )
    ReportAccess.create!(
      group: User.first.user_group.first,
      report: report
    )
  end


  SAMPLE_REPORT_LAYOUTS.each do |title, widget|
    report =
      Report.create!(
        name: title,
        description: "Description of #{title}",
        owner: user
      )
    print "#"
    widget[:layout].each_with_index do |widget_layout, index|
      kpi_name = widget[:kpis][index] || KPI::KPI_NAMES.sample
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
end

report = Report.create!(
      name: "June 2019 Pop-up store event report",
      owner: User.second
    )
    ReportAccess.create!(
      group: User.first.user_group.first,
      report: report
    )


if ENV["orders"] == "reset"
  puts "-" * 30
  puts "RESETTING ORDERS"
  puts "-" * 30
  destroy_order_seeds()
  seed_amazon_orders()
  seed_shopify_orders()
elsif ENV["orders"] == "shopify"
  puts "-" * 30
  puts "SEEDING SHOPIFY ORDERS"
  puts "-" * 30
  destroy_order_seeds("Shopify")
  seed_shopify_orders()
end
