defmodule AOC.Days.Day06 do
  @moduledoc """
  Advent of Code 2025 - Day 6
  """

  @doc """
  Solves part 1 of day 6.
  """
  def part1(input) do
    input
    |> parse()
    |> solve_part1()
  end

  @doc """
  Solves part 2 of day 6.
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

  defp solve_part1(data) do
    data
    |> Enum.map(fn line -> String.split(line, " ", trim: true) end)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(fn line ->
      [last | rest] = Enum.reverse(line)

      rest =
        rest
        |> Enum.map(&String.to_integer/1)

      solve_question([last] ++ rest)
    end)
    |> Enum.sum()
  end

  defp solve_part2(data) do
    data
    |> transpose()
    |> group_questions()
    |> format_questions()
    |> Enum.map(&solve_question/1)
    |> Enum.sum()
  end

  defp transpose(lines) do
    max_len = lines |> Enum.map(&String.length/1) |> Enum.max()

    lines
    |> Enum.map(&String.pad_trailing(&1, max_len))
    |> Enum.map(&String.graphemes/1)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  defp group_questions(data) do
    data
    |> Enum.chunk_by(fn row -> Enum.all?(row, &(&1 == " ")) end)
    |> Enum.reject(fn chunk -> Enum.all?(hd(chunk), &(&1 == " ")) end)
  end

  defp format_questions(data) do
    data
    |> Enum.map(fn question ->
      operator =
        question
        |> Enum.map(&List.last/1)
        |> Enum.find(&(&1 != " "))

      operands =
        question
        |> Enum.map(fn row ->
          row
          |> Enum.drop(-1)
          |> Enum.reject(&(&1 == " "))
          |> Enum.join()
          |> String.to_integer()
        end)

      [operator] ++ operands
    end)
  end

  defp solve_question([operator | operands]) do
    case operator do
      "*" -> Enum.product(operands)
      _ -> Enum.sum(operands)
    end
  end

  @doc """
  Runs both parts with the actual input and prints results with timing.
  """
  def solve do
    input = AOC.read_input(6)

    AOC.solve_with_timing(6, 1, fn -> part1(input) end)
    AOC.solve_with_timing(6, 2, fn -> part2(input) end)
  end
end
