module Solutions
  def self.p1
    dial = 50
    res = Tools.autofetch.reduce(Hash.new(0)) do |acc, l|
      clicks = l[1..].to_i
      dial = (l[0] == 'R' ? dial + clicks : dial - clicks) % 100
      acc[dial] += 1
      acc
    end
    p res[0]
  end

  def self.p2
    dial, max = 50, 100
    passes = 0
    Tools.autofetch.each do |l|
      clicks = l[1..].to_i
      if l[0] == 'R'
        passes += (dial + clicks) / max
        dial = (dial + clicks) % max
      else
        x = clicks < dial ? 0 : 1+((clicks - dial) / max)
        x = clicks / max if dial == 0
        passes += x
        dial = (dial - clicks) % max
      end
    end
    p passes
  end
end
