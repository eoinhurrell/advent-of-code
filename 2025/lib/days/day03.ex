defmodule AOC.Days.Day03 do
  @moduledoc """
  Advent of Code 2025 - Day 3
  """

  @doc """
  Solves part 1 of day 3.
  """
  def part1(input) do
    input
    |> parse()
    |> solve_part1()
  end

  @doc """
  Solves part 2 of day 3.
  """
  def part2(input) do
    input
    |> parse()
    |> solve_part2()
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
  end

  defp get_joltage(battery, max_size) do
    digits = String.graphemes(battery)
    len = length(digits)

    {result, _} =
      Enum.reduce(1..max_size, {[], 0}, fn i, {acc, start_idx} ->
        # Must leave (max_size - i) digits after our pick
        end_idx = len - (max_size - i) - 1

        # Find largest digit in valid range
        {max_digit, max_idx} =
          digits
          |> Enum.slice(start_idx..end_idx)
          |> Enum.with_index(start_idx)
          |> Enum.max_by(fn {d, _idx} -> d end)

        {acc ++ [max_digit], max_idx + 1}
      end)

    Enum.join(result)
    |> String.to_integer()
  end

  defp solve_part1(data) do
    data
    |> Enum.map(fn battery -> get_joltage(battery, 2) end)
    |> Enum.sum()
  end

  defp solve_part2(data) do
    data
    |> Enum.map(fn battery -> get_joltage(battery, 12) end)
    |> Enum.sum()
  end

  @doc """
  Runs both parts with the actual input and prints results with timing.
  """
  def solve do
    input = AOC.read_input(3)

    AOC.solve_with_timing(3, 1, fn -> part1(input) end)
    AOC.solve_with_timing(3, 2, fn -> part2(input) end)
  end
end
