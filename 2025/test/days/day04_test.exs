defmodule AOC.Days.Day04Test do
  use ExUnit.Case
  alias AOC.Days.Day04

  @example_input AOC.read_input(4, :example)

  test "part 1 with example input" do
    result = Day04.part1(@example_input)
    assert result == 13
  end

  test "part 2 with example input" do
    result = Day04.part2(@example_input)
    assert result == 43
  end
end
