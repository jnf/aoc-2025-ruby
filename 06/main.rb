# internal API goes up here
def human(raw)
  raw.split(/\n/).reduce([]) do |acc, line|
    line = line.strip.split(/\s+/)
    line.each_index do |idx|
      acc[idx] ||= []
      acc[idx] << line [idx]
    end
    acc
  end
end

def cephlapod(grid, maths: [])
  ops = grid.pop.reject { |s| s == ' ' }.reverse
  grid.first.count.times do |x|
    n = ''
    grid.count.times do |y|
      n << grid[y][-x-1]
    end
    maths << n.to_i # '  '.to_i => 0
  end
  ops.zip(maths.slice_before(0))
end

#external API goes down here
module Solutions
  def self.p1
    maths = human Tools.autoraw
    n = maths.sum do |math|
      op = math.pop.to_sym
      math.map(&:to_i).reduce(&op)
    end
    p n
  end

  def self.p2
    maths = cephlapod Tools.autogrid
    n = maths.sum do |(op, nums)|
      nums.reject { |m| m == 0 }.reduce(&op.to_sym)
    end
    p n
  end
end
