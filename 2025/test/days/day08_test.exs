defmodule AOC.Days.Day08Test do
  use ExUnit.Case
  alias AOC.Days.Day08

  @example_input AOC.read_input(8, :example)

  test "part 1 with example input" do
    result = Day08.part1(@example_input)
    # Should be 40, with 10 connections
    assert result == 20
  end

  test "part 2 with example input" do
    result = Day08.part2(@example_input)
    assert result == 25272
  end
end
