defmodule AOC.Days.Day01 do
  import Enum

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

  defp parse(input) do
    # TODO: Parse input
    lines =
      input
      |> String.split("\n", trim: true)
      |> map(fn line ->
        [first, second] = String.split(line, "\t")
        {String.to_integer(first), String.to_integer(second)}
      end)

    lines
  end

  defp solve_part1(data) do
    # Parse each line and extract the two columns
    result =
      data
      |> unzip()
      |> then(fn {col1, col2} ->
        zip(sort(col1), sort(col2))
      end)
      |> map(fn {a, b} -> abs(a - b) end)
      |> sum()

    result
  end

  defp solve_part2(data) do
    # TODO: Implement part 2
    result =
      data
      |> unzip()
      |> then(fn {col1, col2} ->
        freqs = frequencies(col2)
        map(col1, &(Map.get(freqs, &1, 0) * &1))
      end)
      |> sum()

    Integer.to_string(result)
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
