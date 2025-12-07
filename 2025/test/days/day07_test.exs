defmodule AOC.Days.Day07Test do
  use ExUnit.Case
  alias AOC.Days.Day07

  @example_input AOC.read_input(7, :example)

  test "part 1 with example input" do
    result = Day07.part1(@example_input)
    assert result == 21
  end

  test "part 2 with example input" do
    result = Day07.part2(@example_input)
    assert result == 40
  end
end
