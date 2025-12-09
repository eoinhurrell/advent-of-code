defmodule UnionFind do
  def new(points), do: Map.new(points, &{&1, &1})

  def find(uf, x) do
    case Map.get(uf, x) do
      ^x ->
        {uf, x}

      parent ->
        {uf2, root} = find(uf, parent)
        {Map.put(uf2, x, root), root}
    end
  end

  def union(uf, x, y) do
    {uf, root_x} = find(uf, x)
    {uf, root_y} = find(uf, y)

    if root_x == root_y do
      {uf, false}
    else
      {Map.put(uf, root_x, root_y), true}
    end
  end
end

defmodule Circuits do
  def solve(points, num_connections \\ 1000) do
    points_with_idx = Enum.with_index(points)

    edges =
      for {p1, i} <- points_with_idx, {p2, j} <- points_with_idx, i < j do
        {euclidean(p1, p2), i, j, p1, p2}
      end
      |> Enum.sort()
      |> Enum.take(num_connections)

    uf = UnionFind.new(points)

    uf =
      Enum.reduce(edges, uf, fn {_dist, _i, _j, p1, p2}, uf ->
        {uf, _merged?} = UnionFind.union(uf, p1, p2)
        uf
      end)

    points
    |> Enum.map(fn p -> UnionFind.find(uf, p) |> elem(1) end)
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product()
  end

  def solve_part2(points) do
    points_with_idx = Enum.with_index(points)

    edges =
      for {p1, i} <- points_with_idx, {p2, j} <- points_with_idx, i < j do
        {euclidean(p1, p2), i, j, p1, p2}
      end
      |> Enum.sort()

    uf = UnionFind.new(points)

    find_final_merge(edges, uf, length(points))
  end

  defp find_final_merge([{_dist, _i, _j, p1, p2} | rest], uf, num_components) do
    {uf, root1} = UnionFind.find(uf, p1)
    {uf, root2} = UnionFind.find(uf, p2)

    if root1 == root2 do
      # Already in same circuit, skip
      find_final_merge(rest, uf, num_components)
    else
      # Merge them
      {uf, _} = UnionFind.union(uf, p1, p2)
      new_count = num_components - 1

      if new_count == 1 do
        # This was the final merge!
        {x1, _, _} = p1
        {x2, _, _} = p2
        x1 * x2
      else
        find_final_merge(rest, uf, new_count)
      end
    end
  end

  defp euclidean({x1, y1, z1}, {x2, y2, z2}) do
    :math.sqrt((x1 - x2) ** 2 + (y1 - y2) ** 2 + (z1 - z2) ** 2)
  end
end

defmodule AOC.Days.Day08 do
  @moduledoc """
  Advent of Code 2025 - Day 8
  """

  @doc """
  Solves part 1 of day 8.
  """
  def part1(input) do
    input
    |> parse()
    |> solve_part1()
  end

  @doc """
  Solves part 2 of day 8.
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

  defp solve_part1(data) do
    Circuits.solve(data, 1000)
  end

  defp solve_part2(data) do
    Circuits.solve_part2(data)
  end

  @doc """
  Runs both parts with the actual input and prints results with timing.
  """
  def solve do
    input = AOC.read_input(8)

    AOC.solve_with_timing(8, 1, fn -> part1(input) end)
    AOC.solve_with_timing(8, 2, fn -> part2(input) end)
  end
end
