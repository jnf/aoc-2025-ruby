# internal API goes up here
def to_ranges(list)
  list.map do |raw|
    x, y = raw.split('-')
    (x.to_i..y.to_i)
  end
end

def process(blk)
  input = to_ranges Tools.autoraw.chomp.split(',')
  input.flat_map do |range|
    range.select(&blk)
  end
end

#external API goes down here
module Solutions
  def self.p1
    blk = -> (num) do
      str = num.to_s
      s1, s2 = [str[0, str.size/2], str[str.size/2..-1]]
      s1 == s2 && s1[0] != '0'
    end
    p process(blk).sum
  end

  def self.p2
    r = /^(.+)\1+$/
    blk = -> (num) { r.match? num.to_s }
    p process(blk).sum
  end
end
