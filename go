#! /usr/bin/env ruby
DAY, part, test = ARGV
raise "which day?" unless DAY
TEST = test || "fake"
PART = part || "p1"

puts [DAY, PART, TEST].join(', ')

require_relative "tools"
require_relative "./#{DAY}/main"

Solutions.send(PART.to_sym)
