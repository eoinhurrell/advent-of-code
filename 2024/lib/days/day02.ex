defmodule AOC.Days.Day02 do
  import Enum

  @moduledoc """
  Advent of Code 2025 - Day 2
  """

  @doc """
  Solves part 1 of day 2.
  """
  def part1(input) do
    input
    |> parse()
    |> solve_part1()
  end

  @doc """
  Solves part 2 of day 2.
  """
  def part2(input) do
    input
    |> parse()
    |> solve_part2()
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> map(fn line ->
      String.split(line, " ") |> map(&String.to_integer/1)
    end)
  end

  defp valid_sequence?(diffs) do
    in_range? = all?(diffs, fn d -> abs(d) in 1..3 end)
    monotonic? = all?(diffs, &(&1 > 0)) or all?(diffs, &(&1 < 0))
    in_range? and monotonic?
  end

  defp solve_part1(data) do
    data
    |> map(fn list ->
      list
      |> chunk_every(2, 1, :discard)
      |> map(fn [a, b] -> b - a end)
      |> valid_sequence?()
    end)
    |> count(& &1)
  end

  defp dampened_valid_sequence?(diffs) do
    in_range? = all?(diffs, fn d -> abs(d) in 1..3 end)
    # out_of_range_count = count(diffs, fn d -> abs(d) not in 1..3 end)
    monotonic? = all?(diffs, &(&1 > 0)) or all?(diffs, &(&1 < 0))
    in_range? and monotonic?
  end

  defp solve_part2(data) do
    data
    |> map(fn list ->
      list
      |> chunk_every(2, 1, :discard)
      |> map(fn [a, b] -> b - a end)
      |> dampened_valid_sequence?()
    end)
    |> count(& &1)
  end

  @doc """
  Runs both parts with the actual input and prints results.
  """
  def solve do
    input = AOC.read_input(2)

    IO.puts("Day 2 - Part 1: #{part1(input)}")
    IO.puts("Day 2 - Part 2: #{part2(input)}")
  end
end
