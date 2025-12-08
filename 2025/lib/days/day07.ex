defmodule AOC.Days.Day07 do
  @moduledoc """
  Advent of Code 2025 - Day 7
  """

  @doc """
  Solves part 1 of day 7.
  """
  def part1(input) do
    input
    |> parse()
    |> solve_part1()
  end

  @doc """
  Solves part 2 of day 7.
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

  defp find_start(map) do
    {pos, _length} =
      map
      |> List.first()
      |> :binary.match("S")

    [_head | tail] = map
    {tail, {0, [pos]}}
  end

  defp count_splits(row, positions) do
    max_idx = String.length(row) - 1

    positions
    |> Enum.reduce({0, MapSet.new()}, fn idx, {count, acc_set} ->
      case String.at(row, idx) do
        "^" ->
          new = [idx - 1, idx + 1] |> Enum.filter(&(&1 >= 0 and &1 <= max_idx))
          updated = acc_set |> MapSet.delete(idx) |> MapSet.union(MapSet.new(new))
          {count + 1, updated}

        _ ->
          {count, MapSet.put(acc_set, idx)}
      end
    end)
  end

  defp solve_part1(data) do
    data
    |> find_start()
    |> then(fn {map, acc} ->
      Enum.reduce(map, acc, fn row, {count, positions} ->
        {row_count, new_positions} = count_splits(row, positions)
        {count + row_count, new_positions}
      end)
    end)
    |> elem(0)
  end

  defp count_timelines(data) do
    {_data, {_, [start_col]}} = find_start(data)

    initial = %{start_col => 1}

    data
    |> Enum.drop(1)
    |> Enum.reduce(initial, fn row, positions ->
      positions
      |> Enum.flat_map(fn {col, count} ->
        case String.at(row, col) do
          "^" ->
            # Split: each timeline becomes two timelines
            [{col - 1, count}, {col + 1, count}]

          "." ->
            # Continue straight
            [{col, count}]

          _ ->
            # Path ends or continues?
            []
        end
      end)
      |> Enum.reduce(%{}, fn {col, count}, acc ->
        # Merge timelines that arrive at same position
        Map.update(acc, col, count, &(&1 + count))
      end)
    end)
    |> Map.values()
    |> Enum.sum()
  end

  defp solve_part2(data) do
    data
    |> count_timelines()
  end

  @doc """
  Runs both parts with the actual input and prints results with timing.
  """
  def solve do
    input = AOC.read_input(7)

    AOC.solve_with_timing(7, 1, fn -> part1(input) end)
    AOC.solve_with_timing(7, 2, fn -> part2(input) end)
  end
end
