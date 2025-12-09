defmodule AOC.Days.Day09Test do
  use ExUnit.Case
  alias AOC.Days.Day09

  @example_input AOC.read_input(9, :example)

  test "part 1 with example input" do
    result = Day09.part1(@example_input)
    assert result == 50
  end

  test "part 2 with example input" do
    result = Day09.part2(@example_input)
    # TODO: Update expected value
    assert result == nil
  end
end
