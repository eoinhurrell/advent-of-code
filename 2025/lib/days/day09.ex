defmodule AOC.Days.Day09 do
  @moduledoc """
  Advent of Code 2025 - Day 9
  """

  @doc """
  Solves part 1 of day 9.
  """
  def part1(input) do
    input
    |> parse()
    |> solve_part1()
  end

  @doc """
  Solves part 2 of day 9.
  """
  def part2(input) do
    input
    |> parse()
    |> solve_part2()
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
    end)
  end

  def max_rectangle_area(points) do
    points
    |> Enum.with_index()
    |> Enum.reduce(0, fn {{x1, y1}, i}, max_area ->
      points
      |> Enum.drop(i + 1)
      |> Enum.reduce(max_area, fn {x2, y2}, acc ->
        if x1 == x2 or y1 == y2 do
          acc
        else
          # Count tiles inclusively: add 1 to each dimension
          area = (abs(x2 - x1) + 1) * (abs(y2 - y1) + 1)
          max(acc, area)
        end
      end)
    end)
  end

  defp solve_part1(data) do
    max_rectangle_area(data)
  end

  def max_rectangle_area_with_polygon(coords) do
    n_coords = length(coords)

    # Generate all rectangles sorted by area (largest first)
    area_coords_index =
      coords
      |> Enum.with_index()
      |> combinations(2)
      |> Enum.map(fn [{c1, i}, {c2, _}] ->
        area = (abs(elem(c2, 0) - elem(c1, 0)) + 1) * (abs(elem(c2, 1) - elem(c1, 1)) + 1)
        {area, c1, c2, i}
      end)
      |> Enum.sort_by(fn {area, _, _, _} -> -area end)

    # Find first rectangle where no edge crosses through interior
    Enum.find_value(area_coords_index, fn {area, coord1, coord2, index} ->
      {left, right} = Enum.min_max([elem(coord1, 0), elem(coord2, 0)])
      {lo, hi} = Enum.min_max([elem(coord1, 1), elem(coord2, 1)])

      # Check all edges in the polygon
      edge_crosses =
        0..(n_coords - 1)
        |> Enum.reduce_while({coord1, false}, fn i, {{x2, y2}, _crossed} ->
          {x1, y1} = {x2, y2}
          {x2, y2} = Enum.at(coords, rem(index + i, n_coords))

          {xmin, xmax} = Enum.min_max([x1, x2])
          {ymin, ymax} = Enum.min_max([y1, y2])

          # Check if edge crosses through rectangle interior
          crosses =
            (left < x1 and x1 < right and lo < y1 and y1 < hi) or
              (lo < y1 and y1 < hi and xmin <= left and left < xmax and xmin < right and
                 right <= xmax) or
              (left < x1 and x1 < right and ymin <= lo and lo < ymax and ymin < hi and hi <= ymax)

          if crosses do
            {:halt, {{x2, y2}, true}}
          else
            {:cont, {{x2, y2}, false}}
          end
        end)
        |> elem(1)

      if not edge_crosses, do: area, else: nil
    end)
  end

  defp combinations(list, 2) do
    for {a, i} <- Enum.with_index(list),
        {b, j} <- Enum.with_index(list),
        i < j,
        do: [a, b]
  end

  defp solve_part2(data) do
    max_rectangle_area_with_polygon(data)
  end

  @doc """
  Runs both parts with the actual input and prints results with timing.
  """
  def solve do
    input = AOC.read_input(9)

    AOC.solve_with_timing(9, 1, fn -> part1(input) end)
    AOC.solve_with_timing(9, 2, fn -> part2(input) end)
  end
end
