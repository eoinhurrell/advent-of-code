defmodule AOC.Days.Day01 do
  @moduledoc """
  Advent of Code 2025 - Day 1
  """

  @doc """
  Solves part 1 of day 1.
  """
  def part1(input) do
    input
    |> parse()
    |> solve_part1()
  end

  @doc """
  Solves part 2 of day 1.
  """
  def part2(input) do
    input
    |> parse()
    |> solve_part2()
  end


  defp parse_line("L" <> rest), do: -String.to_integer(rest)
  defp parse_line("R" <> rest), do: String.to_integer(rest)

  # How many steps until we first hit 0?
  defp steps_to_first_zero(0, _delta), do: 100  # already at 0, need full rotation
  defp steps_to_first_zero(pos, delta) when delta < 0, do: pos        # going left, count down
  defp steps_to_first_zero(pos, delta) when delta > 0, do: 100 - pos  # going right, count up

  defp count_zeros_crossed(pos, delta) do
    steps = abs(delta)
    first = steps_to_first_zero(pos, delta)

    if steps < first do
      0
    else
      1 + div(steps - first, 100)
    end
  end

  defp parse(input) do
    lines =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&parse_line/1)

    lines
  end

  defp solve_part1(data) do
    # Simple count
    data
    |> Enum.scan(50, fn x, acc -> Integer.mod(acc + x, 100) end)
    |> Enum.count(&(&1 == 0))
  end

  defp solve_part2(data) do
    # More awkward, count times rotation passes 0
    data
    |> Enum.reduce({50, 0}, fn delta, {pos, zeros} ->
      new_zeros = count_zeros_crossed(pos, delta)
      new_pos = Integer.mod(pos + delta, 100)
      {new_pos, zeros + new_zeros}
    end)
    |> elem(1)
  end

  @doc """
  Runs both parts with the actual input and prints results.
  """
  def solve do
    input = AOC.read_input(1)

    IO.puts("Day 1 - Part 1: #{part1(input)}")
    IO.puts("Day 1 - Part 2: #{part2(input)}")
  end
end
