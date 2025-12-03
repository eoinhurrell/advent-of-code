defmodule Mix.Tasks.Aoc.Gen do
  use Mix.Task

  @shortdoc "Generates scaffolding for a new Advent of Code day"

  @moduledoc """
  Generates the necessary files for a new Advent of Code day.

  ## Usage

      mix aoc.gen <day>

  ## Examples

      mix aoc.gen 1
      mix aoc.gen 15

  This will create:
  - lib/days/dayXX.ex - Solution module
  - test/days/dayXX_test.exs - Test file
  - inputs/dayXX/input.txt - Puzzle input (empty)
  - inputs/dayXX/example.txt - Example input (empty)
  """

  @impl Mix.Task
  def run([day_str]) do
    day = String.to_integer(day_str)
    day_padded = String.pad_leading(day_str, 2, "0")
    day_module = "Day#{day_padded}"

    # Ensure we're in the project root
    project_root = File.cwd!()

    # Create directories
    input_dir = Path.join(project_root, "inputs/day#{day_padded}")
    File.mkdir_p!(input_dir)

    lib_days_dir = Path.join(project_root, "lib/days")
    File.mkdir_p!(lib_days_dir)

    test_days_dir = Path.join(project_root, "test/days")
    File.mkdir_p!(test_days_dir)

    # Create solution file
    solution_path = Path.join(project_root, "lib/days/day#{day_padded}.ex")
    solution_content = solution_template(day_module, day)
    File.write!(solution_path, solution_content)
    Mix.shell().info([:green, "* creating ", :reset, Path.relative_to_cwd(solution_path)])

    # Create test file
    test_path = Path.join(project_root, "test/days/day#{day_padded}_test.exs")
    test_content = test_template(day_module, day)
    File.write!(test_path, test_content)
    Mix.shell().info([:green, "* creating ", :reset, Path.relative_to_cwd(test_path)])

    # Create input files
    input_file = Path.join(input_dir, "input.txt")
    example_file = Path.join(input_dir, "example.txt")

    File.write!(input_file, "")
    Mix.shell().info([:green, "* creating ", :reset, Path.relative_to_cwd(input_file)])

    File.write!(example_file, "")
    Mix.shell().info([:green, "* creating ", :reset, Path.relative_to_cwd(example_file)])

    Mix.shell().info("\nDay #{day} scaffolding created successfully!")
    Mix.shell().info("\nNext steps:")
    Mix.shell().info("  1. Add your puzzle input to #{Path.relative_to_cwd(input_file)}")
    Mix.shell().info("  2. Add example input to #{Path.relative_to_cwd(example_file)}")
    Mix.shell().info("  3. Implement solutions in #{Path.relative_to_cwd(solution_path)}")
    Mix.shell().info("  4. Run tests: mix test #{Path.relative_to_cwd(test_path)}")
    Mix.shell().info("  5. Run solution: mix run -e \"AOC.Days.#{day_module}.solve()\"")
  end

  def run(_) do
    Mix.shell().error("Usage: mix aoc.gen <day>")
    Mix.shell().info("Example: mix aoc.gen 1")
  end

  defp solution_template(module_name, day) do
    """
    defmodule AOC.Days.#{module_name} do
      @moduledoc \"\"\"
      Advent of Code 2025 - Day #{day}
      \"\"\"

      @doc \"\"\"
      Solves part 1 of day #{day}.
      \"\"\"
      def part1(input) do
        input
        |> parse()
        |> solve_part1()
      end

      @doc \"\"\"
      Solves part 2 of day #{day}.
      \"\"\"
      def part2(input) do
        input
        |> parse()
        |> solve_part2()
      end

      defp parse(input) do
        # TODO: Parse input
        input
      end

      defp solve_part1(data) do
        # TODO: Implement part 1
        data
      end

      defp solve_part2(data) do
        # TODO: Implement part 2
        data
      end

      @doc \"\"\"
      Runs both parts with the actual input and prints results with timing.
      \"\"\"
      def solve do
        input = AOC.read_input(#{day})

        AOC.solve_with_timing(#{day}, 1, fn -> part1(input) end)
        AOC.solve_with_timing(#{day}, 2, fn -> part2(input) end)
      end
    end
    """
  end

  defp test_template(module_name, day) do
    """
    defmodule AOC.Days.#{module_name}Test do
      use ExUnit.Case
      alias AOC.Days.#{module_name}

      @example_input AOC.read_input(#{day}, :example)

      test "part 1 with example input" do
        result = #{module_name}.part1(@example_input)
        # TODO: Update expected value
        assert result == nil
      end

      test "part 2 with example input" do
        result = #{module_name}.part2(@example_input)
        # TODO: Update expected value
        assert result == nil
      end
    end
    """
  end
end
