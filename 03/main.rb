# internal API goes up here
def max_joltage(bank, n)
  jolts = ''
  n.times do |i|
    win = bank[0..-(n-i)]
    idx = win.index win.max
    jolts += win[idx]
    bank = bank[idx+1..]
  end
  jolts.to_i
end

#external API goes down here
module Solutions
  def self.p1
    p Tools.autogrid.sum{ |bank| max_joltage(bank, 2) }
  end

  def self.p2
    p Tools.autogrid.sum { |bank| max_joltage(bank, 12) }
  end
end
