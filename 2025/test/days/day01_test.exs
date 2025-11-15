defmodule AOC.Days.Day01Test do
  use ExUnit.Case
  alias AOC.Days.Day01

  @example_input AOC.read_input(1, :example)

  test "part 1 with example input" do
    result = Day01.part1(@example_input)
    # Example: Sum of 1+2+3+4+5 = 15
    assert result == 15
  end

  test "part 2 with example input" do
    result = Day01.part2(@example_input)
    # Example: Product of 1*2*3*4*5 = 120
    assert result == 120
  end
end
