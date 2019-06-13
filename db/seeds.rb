require_relative 'seed_orders'

COMPANIES = [
  {
    name: "Loquence"
  }
]

GROUPS = [
  {name: "IT"},
  {name: "Marketing"},
  {name: "Logistics"},
  {name: "Customer Support"},
]

USERS = [
  {
    first_name: "Trouni",
    last_name: "T.",
    email: "trouni@loquence.co",
    password: "secret"
  },
  {first_name: "Saad",
    last_name: "Saad",
    email: "saad@loquence.co",
    password: "secret"
  },
  {first_name: "Alex",
    last_name: "Remp",
    email: "alex@loquence.co",
    password: "secret"
  },
  {first_name: "Eugene",
    last_name: "Eugene",
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

if ENV["orders"] == "reset"
  puts "-" * 30
  puts "RESETTING ORDERS"
  puts "-" * 30
  destroy_order_seeds()
  seed_orders()
elsif ENV["orders"]
  puts "-" * 30
  puts "UPDATING ORDERS"
  puts "-" * 30
  seed_orders()
end


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


puts "Creating companies & users..."


USERS.each do |user|
  user = User.create!(first_name: user[:first_name], last_name: user[:last_name], email: user[:email], password: user[:password])
end

COMPANIES.each do |company|
  Company.create!(name: company[:name], owner: User.first)
end


GROUPS.each do |group|
  Group.create!(name: group[:name])
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
