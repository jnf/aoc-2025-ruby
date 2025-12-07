def munge(raw)
  rraw, iraw = raw.split(/\n\n/)
  its = iraw.split(/\n/).map(&:to_i)
  rngs = rraw.split(/\n/).map { |str| str.split('-').map(&:to_i) }
  [rngs, its]
end

def ols(rngs, collapsed: [], found: false)
  while rngs.any?
    minmin, minmax = rngs.shift
    overlaps, rngs = rngs.partition do |(rmin, rmax)|
      minmin <= rmin && minmax >= rmin
    end
    found = found || overlaps.any?
    maxoverlap = overlaps.max_by { |(_, m)| m }&.last
    collapsed << [minmin, [(maxoverlap || 0), minmax].max]
  end

  found ? ols(collapsed) : collapsed
end

#external API goes down here
module Solutions
  def self.p1
    rngs, its = munge Tools.autoraw
    p its.count { |it| rngs.any? { |(min, max)| min <= it && it <= max } }
  end

  def self.p2
    rngs, _ = munge Tools.autoraw
    rngs.sort_by!(&:first)
    p ols(rngs).sum { |(a, b)| b - a + 1 }
  end
end
