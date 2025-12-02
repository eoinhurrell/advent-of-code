defmodule AOC.Days.Day02 do
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

  defp filter_valid(ranges) do
    ranges
    |> Enum.flat_map(fn [start, finish] ->
      Enum.filter(start..finish, &is_invalid?/1)
    end)
  end

  defp is_invalid?(product_id) do
    id_string = Integer.to_string(product_id)
    mid = div(String.length(id_string), 2)
    {left, right} = String.split_at(id_string, mid)
    left == right
  end

  defp part2_filter_valid(ranges) do
    ranges
    |> Enum.flat_map(fn [start, finish] ->
      Enum.filter(start..finish, &part2_is_invalid?/1)
    end)
  end

  defp part2_is_invalid?(product_id) do
    Regex.match?(~r/^(.+)\1+$/, Integer.to_string(product_id))
  end

  defp parse(input) do
    input
    |> String.trim()
    |> String.split(",")
    |> Enum.map(fn range ->
      range
      |> String.split("-")
      |> Enum.map(&String.to_integer/1)
    end)
  end

  defp solve_part1(data) do
    data
    |> filter_valid()
    |> Enum.sum()
  end

  defp solve_part2(data) do
    data
    |> part2_filter_valid()
    |> Enum.sum()
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
