defmodule AOC.Days.Day01Test do
  use ExUnit.Case
  alias AOC.Days.Day01

  @example_input AOC.read_input(1, :example)

  test "part 1 with example input" do
    result = Day01.part1(@example_input)
    assert result == 3
  end

  test "part 2 with example input" do
    result = Day01.part2(@example_input)
    assert result == 6
  end
end
