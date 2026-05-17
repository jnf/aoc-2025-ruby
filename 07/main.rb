# internal API goes up here
class GraphBuilder
  attr_reader :grid, :graph, :exits, :inverse

  def initialize(grid)
    @grid = grid
    @graph = build_graph
    @exits = {}
    @inverse = graph.reduce({}) do |acc, (k, v)|
      v.each { |n| acc[n] ||= []; acc[n] << k }
      acc
    end
  end

  def end_nodes
    graph.values.flatten(1).reject { |n| graph.graph.key? n }.uniq
  end

  def find_paths(node, memo = {})
    return memo[node] if memo.key?(node)
    children = graph[node]
    return memo[node] = 1 if children.nil? || children.empty?
    memo[node] = children.sum { |child| find_paths(child, memo) }
  end

  def build_graph
    beams = Array.new(grid[0].count) # list of x coords for beams
    beams[grid[0].find_index('S')] = true
    g = Hash.new { |h,k| h[k] = [] }
    grid.each_index do |y|
      carets = grid[y].each_index.select { |x| grid[y][x] == '^' } # find our splitters
      carets.each do |x|
        if beams[x]
          unless x == 0
            beams[x-1] = true
            g[[y-1,x]] << [y,x-1]
          end
          unless x >= grid[y].count - 1
            beams[x+1] = true
            g[[y-1,x]] << [y,x+1]
          end
        end
        beams[x] = false # beams end at splitters
      end

      beams.each_with_index do |v, x|
        next unless v
        next if grid[y][x] == '^'
        g[[y-1, x]] << [y, x] unless y == 0
      end
    end
    g
  end
end

#external API goes down here
module Solutions
  def self.p1
    graph = GraphBuilder.new(Tools.autogrid).graph
    splits = graph.values.count { |v| v.count > 1 }
    p({splits:})
  end

  def self.p2
    gb = GraphBuilder.new(Tools.autogrid)
    source = gb.graph.keys.find { |y, _| y == 0 }
    v = gb.find_paths(source)
    p({v:})
  end
end
