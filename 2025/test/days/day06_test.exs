defmodule AOC.Days.Day06Test do
  use ExUnit.Case
  alias AOC.Days.Day06

  @example_input AOC.read_input(6, :example)

  test "part 1 with example input" do
    result = Day06.part1(@example_input)
    assert result == 4_277_556
  end

  test "part 2 with example input" do
    result = Day06.part2(@example_input)
    assert result == 3_263_827
  end
end
