defmodule AOC.Days.Day03Test do
  use ExUnit.Case
  alias AOC.Days.Day03

  @example_input AOC.read_input(3, :example)

  test "part 1 with example input" do
    result = Day03.part1(@example_input)
    assert result == 357
  end

  test "part 2 with example input" do
    result = Day03.part2(@example_input)
    assert result == 3_121_910_778_619
  end
end
