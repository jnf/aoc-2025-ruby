#! /usr/bin/env ruby --yjit

require 'benchmark'

DAY, part, test = ARGV
raise "which day?" unless DAY
TEST = test || "fake"
PART = part || "p1"

puts [DAY, PART, TEST].join(', ')

require_relative "tools"
require_relative "./#{DAY}/main"

t = Benchmark.measure do
  Solutions.send(PART.to_sym)
end

puts 
puts '-'*50
puts 'user system total real'
puts t
puts '-'*50
