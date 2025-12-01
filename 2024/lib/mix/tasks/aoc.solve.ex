defmodule Mix.Tasks.Aoc.Solve do
  use Mix.Task

  @shortdoc "Runs an Advent of Code solution for a specific day and part"

  @moduledoc """
  Runs an Advent of Code solution for a specific day and optionally a specific part.

  ## Usage

      mix aoc.solve <day>           # Runs both parts
      mix aoc.solve <day> -p <part> # Runs specific part
      mix aoc.solve <day> --part <part>

  ## Examples

      mix aoc.solve 1        # Run both parts of day 1
      mix aoc.solve 1 -p 1   # Run only part 1 of day 1
      mix aoc.solve 5 --part 2  # Run only part 2 of day 5

  ## Options

    * `-p`, `--part` - Specify which part to run (1 or 2). If not provided, runs both parts.
  """

  @impl Mix.Task
  def run(args) do
    Mix.Task.run("compile")

    {opts, args, _invalid} =
      OptionParser.parse(args,
        strict: [part: :integer],
        aliases: [p: :part]
      )

    case args do
      [day_str] ->
        day = String.to_integer(day_str)

        case opts[:part] do
          nil ->
            # Run both parts
            AOC.solve_day(day)

          part when part in [1, 2] ->
            # Run specific part
            AOC.solve_part(day, part)

          part ->
            Mix.shell().error("Invalid part: #{part}. Must be 1 or 2.")
        end

      [] ->
        Mix.shell().error("Usage: mix aoc.solve <day> [-p <part>]")
        Mix.shell().info("Examples:")
        Mix.shell().info("  mix aoc.solve 1        # Run both parts")
        Mix.shell().info("  mix aoc.solve 1 -p 1   # Run part 1 only")
        Mix.shell().info("  mix aoc.solve 1 -p 2   # Run part 2 only")

      _ ->
        Mix.shell().error("Too many arguments. Usage: mix aoc.solve <day> [-p <part>]")
    end
  end
end
