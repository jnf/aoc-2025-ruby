# internal API goes up here

#external API goes down here
module Solutions
  def self.p1
    grid = Tools.autogrid
    beams = Array.new(grid[0].count)
    beams[grid[0].find_index('S')] = true # list of x coords for beams
    splits = 0
    grid.each_index do |y|
      carets = grid[y].each_index.select { |x| grid[y][x] == '^' } # find our splitters
      carets.each do |x|
        splits += 1 if beams[x]
        beams[x] = false # beams end at splitters
        beams[x-1] = true unless x == 0
        beams[x+1] = true unless x >= grid[y].count - 1
      end
      # beams.each_with_index do |v, x|
      #   grid[y][x] = '|' if v && grid[y][x] != '^'
      # end
    end
    p({splits:})
  end

  def self.p2

  end
end
