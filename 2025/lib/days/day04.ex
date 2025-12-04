defmodule AOC.Days.Day04 do
  @moduledoc """
  Advent of Code 2025 - Day 4
  """

  @doc """
  Solves part 1 of day 4.
  """
  def part1(input) do
    input
    |> parse()
    |> solve_part1()
  end

  @doc """
  Solves part 2 of day 4.
  """
  def part2(input) do
    input
    |> parse()
    |> solve_part2()
  end

  defp neighbours({row, col}) do
    for dr <- [-1, 0, 1],
        dc <- [-1, 0, 1],
        {dr, dc} != {0, 0} do
      {row + dr, col + dc}
    end
  end

  defp count_blocked_neighbours(grid, pos) do
    neighbours(pos)
    |> Enum.count(fn n_pos -> Map.get(grid, n_pos) == "@" end)
  end

  defp remove_until_stable(grid, total_count) do
    # Find all @ positions with < 4 blocked neighbours
    to_remove =
      grid
      |> Enum.filter(fn {pos, char} ->
        char == "@" and count_blocked_neighbours(grid, pos) < 4
      end)
      |> Enum.map(fn {pos, _char} -> pos end)

    case to_remove do
      [] ->
        # No more to remove, return total
        total_count

      positions ->
        # Remove these positions (change @ to .)
        new_grid =
          Enum.reduce(positions, grid, fn pos, acc ->
            Map.put(acc, pos, ".")
          end)

        # Recur with updated grid and count
        remove_until_stable(new_grid, total_count + length(positions))
    end
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, row_idx} ->
      row
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.map(fn {char, col_idx} -> {{row_idx, col_idx}, char} end)
    end)
    |> Map.new()
  end

  defp solve_part1(data) do
    data
    |> Map.keys()
    |> Enum.count(fn pos ->
      Map.get(data, pos) == "@" and count_blocked_neighbours(data, pos) < 4
    end)
  end

  defp solve_part2(data) do
    data
    |> remove_until_stable(0)
  end

  @doc """
  Runs both parts with the actual input and prints results with timing.
  """
  def solve do
    input = AOC.read_input(4)

    AOC.solve_with_timing(4, 1, fn -> part1(input) end)
    AOC.solve_with_timing(4, 2, fn -> part2(input) end)
  end
end
