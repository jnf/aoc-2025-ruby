# internal API goes up here
ADJ = {
  tl: -> (g, y, x) { g[y-1][x-1] },
  tm: -> (g, y, x) { g[y-1][x]   },
  tr: -> (g, y, x) { g[y-1][x+1] },
  ml: -> (g, y, x) { g[y][x-1]   },
  mr: -> (g, y, x) { g[y][x+1]   },
  bl: -> (g, y, x) { g[y+1][x-1] },
  bm: -> (g, y, x) { g[y+1][x]   },
  br: -> (g, y, x) { g[y+1][x+1] },
}

def count_adjs(g, y, x)
  k = ADJ.keys
  k -= [:tl, :tm, :tr] if y <= 0
  k -= [:bl, :bm, :br] if y >= g.count-1
  k -= [:tl, :ml, :bl] if x <= 0
  k -= [:tr, :mr, :br] if x >= g[y].count-1
  k.count { |l| ADJ[l].call(g, y, x) == '@' }
end

def find_movable(g)
  adjs = Array.new(g.count).map { [] }
  g.each_index do |y|
    g[y].count.times do |x|
      adjs[y] << (g[y][x] == '@' ? count_adjs(g, y, x) : 99)
    end
  end
  [adjs.flatten.count { |n| n < 4 }, adjs]
end

#external API goes down here
module Solutions
  def self.p1(g: Tools.autogrid)
    movable, adjs = find_movable(g)
    p movable
  end

  def self.p2
    g = Tools.autogrid
    moved = 0
    movable, adjs = find_movable(g)
    while movable > 0
      adjs.each_index do |y|
        adjs[y].each_index do |x|
          g[y][x] = 'x' if adjs[y][x] < 4
        end
      end
      moved += movable
      movable, adjs = find_movable(g)
    end
    p moved
  end
end
