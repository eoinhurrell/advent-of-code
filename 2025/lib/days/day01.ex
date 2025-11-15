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

  defp parse(input) do
    # Example: Parse input as list of integers
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp solve_part1(numbers) do
    # Example: Sum all numbers
    Enum.sum(numbers)
  end

  defp solve_part2(numbers) do
    # Example: Product of all numbers
    Enum.product(numbers)
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
