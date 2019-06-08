require 'benchmark'

ActiveRecord::Base.logger = nil
n = 100

Benchmark.bm do |benchmark|
  benchmark.report("standard query") do
    n.times do
      Order.distinct.count(:buyer_id)
    end
  end

  benchmark.report("pluck") do
    n.times do
      Order.all.pluck(:buyer_id).uniq.count
    end
  end
end
