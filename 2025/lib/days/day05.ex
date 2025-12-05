defmodule AOC.Days.Day05 do
  @moduledoc """
  Advent of Code 2025 - Day 5
  """

  @doc """
  Solves part 1 of day 5.
  """
  def part1(input) do
    input
    |> parse()
    |> solve_part1()
  end

  @doc """
  Solves part 2 of day 5.
  """
  def part2(input) do
    input
    |> parse()
    |> solve_part2()
  end

  defp parse(input) do
    input
    |> String.split("\n\n", parts: 2)
    |> then(fn [database, stock] ->
      database =
        database
        |> String.split("\n")
        |> Enum.map(fn line ->
          line
          |> String.split("-")
          |> Enum.map(&String.to_integer/1)
        end)
        |> Enum.sort_by(fn [lo, _] -> lo end)
        |> merge_ranges()

      stock =
        stock
        |> String.split("\n", trim: true)
        |> Enum.map(&String.to_integer/1)

      {database, stock}
    end)
  end

  defp merge_ranges(sorted_ranges) do
    sorted_ranges
    |> Enum.reduce([], fn
      [lo, hi], [] ->
        [[lo, hi]]

      [lo, hi], [[prev_lo, prev_hi] | rest] when lo <= prev_hi + 1 ->
        [[prev_lo, max(prev_hi, hi)] | rest]

      range, acc ->
        [range | acc]
    end)
    |> Enum.reverse()
  end

  def search(database, target) do
    search(database, target, 0, length(database) - 1)
  end

  def search([], _target, _min, _max), do: -1

  def search(database, target, min, max) when min <= max do
    mid = div(max + min, 2)

    case Enum.at(database, mid) do
      # found the value
      [low, high] when target >= low and target <= high -> mid
      [low, _high] when target < low -> search(database, target, min, mid - 1)
      _ -> search(database, target, mid + 1, max)
    end
  end

  def search(_list, _target, _min, _max), do: -1

  defp in_range?(database, target) do
    search(database, target) != -1
  end

  defp solve_part1({database, stock}) do
    stock
    |> Enum.count(&in_range?(database, &1))
  end

  defp solve_part2({database, _stock}) do
    database
    |> Enum.map(fn [lo, hi] -> hi - lo + 1 end)
    |> Enum.sum()
  end

  @doc """
  Runs both parts with the actual input and prints results with timing.
  """
  def solve do
    input = AOC.read_input(5)

    AOC.solve_with_timing(5, 1, fn -> part1(input) end)
    AOC.solve_with_timing(5, 2, fn -> part2(input) end)
  end
end
