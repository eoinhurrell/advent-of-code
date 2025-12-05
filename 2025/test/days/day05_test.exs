defmodule AOC.Days.Day05Test do
  use ExUnit.Case
  alias AOC.Days.Day05

  @example_input AOC.read_input(5, :example)

  test "part 1 with example input" do
    result = Day05.part1(@example_input)
    assert result == 3
  end

  test "part 2 with example input" do
    result = Day05.part2(@example_input)
    # TODO: Update expected value
    assert result == 14
  end
end
