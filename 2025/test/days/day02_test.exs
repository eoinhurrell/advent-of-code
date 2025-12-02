defmodule AOC.Days.Day02Test do
  use ExUnit.Case
  alias AOC.Days.Day02

  @example_input AOC.read_input(2, :example)

  test "part 1 with example input" do
    result = Day02.part1(@example_input)
    assert result == 1_227_775_554
  end

  test "part 2 with example input" do
    result = Day02.part2(@example_input)
    assert result == 4_174_379_265
  end
end
