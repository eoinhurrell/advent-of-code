defmodule AOC do
  @moduledoc """
  Advent of Code 2025 - Shared utilities and helpers.
  """

  @doc """
  Reads input file for a given day.

  ## Parameters
  - `day`: The day number (1-25)
  - `type`: Either `:input` (default) or `:example`

  ## Examples

      AOC.read_input(1)           # Reads inputs/day01/input.txt
      AOC.read_input(1, :example) # Reads inputs/day01/example.txt
  """
  def read_input(day, type \\ :input) do
    day_str = day |> Integer.to_string() |> String.pad_leading(2, "0")
    filename = if type == :example, do: "example.txt", else: "input.txt"
    path = Path.join(["inputs", "day#{day_str}", filename])

    File.read!(path)
  end

  @doc """
  Reads input and splits into lines, optionally trimming whitespace.

  ## Examples

      AOC.read_lines(1)
      AOC.read_lines(1, :example)
  """
  def read_lines(day, type \\ :input) do
    day
    |> read_input(type)
    |> String.split("\n", trim: true)
  end

  @doc """
  Helper to time a function execution.

  ## Examples

      AOC.time(fn -> expensive_operation() end)
  """
  def time(fun) do
    {time, result} = :timer.tc(fun)
    IO.puts("Completed in #{time / 1_000_000} seconds")
    result
  end

  @doc """
  Solves a specific part of a specific day and prints the result.

  ## Parameters
  - `day`: The day number (1-25)
  - `part`: The part number (1 or 2)

  ## Examples

      AOC.solve_part(1, 1)  # Solve day 1, part 1
      AOC.solve_part(5, 2)  # Solve day 5, part 2
  """
  def solve_part(day, part) when part in [1, 2] do
    day_padded = day |> Integer.to_string() |> String.pad_leading(2, "0")
    module = Module.concat(AOC.Days, "Day#{day_padded}")
    input = read_input(day)

    result =
      case part do
        1 -> module.part1(input)
        2 -> module.part2(input)
      end

    IO.puts("Day #{day} - Part #{part}: #{result}")
    result
  end

  @doc """
  Solves both parts of a specific day and prints the results.

  ## Parameters
  - `day`: The day number (1-25)

  ## Examples

      AOC.solve_day(1)  # Solve both parts of day 1
  """
  def solve_day(day) do
    day_padded = day |> Integer.to_string() |> String.pad_leading(2, "0")
    module = Module.concat(AOC.Days, "Day#{day_padded}")
    module.solve()
  end
end
