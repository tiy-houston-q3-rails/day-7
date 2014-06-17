require 'pry'

@grid = [
  [2, 4, 8, 512],
  [64, 8, 4, 128],
  [32, 2, 1024, 8],
  [16, 8, 512, 4]
]

def matrix_is_full?
  @grid.flatten.all? do |number|
    number > 0
  end
end

def game_is_over?
  full = matrix_is_full?
  pairs = any_adjacent_pairs?
  binding.pry
  return full && !pairs
end

def any_adjacent_pairs?
  # for all positions in grid, run any_adjacent?

  found_adjacent = false

  @grid.each_with_index do |row, row_number|

    # 4 columns : 0, 1, 2, 3

    row.each_with_index do |column, index|
      if any_adjacent? row_number, index
        found_adjacent = true
        puts [row_number, index].join(',')
      end
    end

  end
  return found_adjacent

end

def any_adjacent?(row, column)
  top = [row-1, column]
  left = [row, column-1]
  down = [row+1, column]
  right = [row, column+1]
  [top, left, down, right].any? do |position|
    does_equal([row, column], position)
  end
end

def does_equal(cell_one, cell_two)

  return false if value_at(cell_one) == 0

  value_at(cell_one) == value_at(cell_two)
end

def value_at(cell)
  x = cell.first
  y = cell.last
  row = @grid[x]
  if row
    value = row[y]
  else
    0
  end
end

def run_game

  puts "over? #{ game_is_over? }"
  print_grid

end

def print_grid
  @grid.each do |row|
    row.each do |i|
      printf "%6d", i
    end
    print "\n"
  end
end

run_game
