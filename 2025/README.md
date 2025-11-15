# Advent of Code 2025

Solutions for [Advent of Code 2025](https://adventofcode.com/2025) written in Elixir.

## Quick Start

### Generate a New Day

```bash
mix aoc.gen <day>
```

This creates:
- `lib/days/dayXX.ex` - Solution module with template
- `test/days/dayXX_test.exs` - Test file
- `inputs/dayXX/input.txt` - Your puzzle input (add manually)
- `inputs/dayXX/example.txt` - Example from puzzle description

### Workflow for Each Day

Each Advent of Code day has **two parts**. Part 2 unlocks after you complete Part 1 and often requires modifying your solution. Here's the recommended workflow:

1. **Generate scaffolding:**
   ```bash
   mix aoc.gen 1
   ```

2. **Add your inputs:**
   - Copy your puzzle input to `inputs/day01/input.txt`
   - Copy the example from the puzzle to `inputs/day01/example.txt`

3. **Solve Part 1:**
   - Implement `parse/1` to parse the input
   - Implement `solve_part1/1` for part 1
   - Update the test in `test/days/day01_test.exs` with expected result
   - Test Part 1: `mix test test/days/day01_test.exs`
   - Run Part 1: `mix aoc.solve 1 -p 1`
   - Submit your answer on adventofcode.com

4. **Solve Part 2 (after Part 1 is complete):**
   - Implement `solve_part2/1` for part 2
   - Update the Part 2 test with expected result
   - Test Part 2: `mix test test/days/day01_test.exs`
   - Run Part 2: `mix aoc.solve 1 -p 2`
   - Submit your answer

5. **Run both parts together:**
   ```bash
   mix aoc.solve 1
   ```

## Project Structure

```
2025/
├── lib/
│   ├── aoc.ex                # Shared utilities (read_input, read_lines, time)
│   ├── days/                 # Daily solutions
│   │   ├── day01.ex
│   │   ├── day02.ex
│   │   └── ...
│   └── mix/tasks/
│       └── aoc.gen.ex        # Mix task for scaffolding
├── inputs/
│   ├── day01/
│   │   ├── input.txt         # Your puzzle input
│   │   └── example.txt       # Example input for testing
│   └── ...
└── test/
    └── days/                 # Tests using example inputs
        ├── day01_test.exs
        └── ...
```

## Working with Parts

Each Advent of Code day consists of two parts that are solved sequentially:

### Running Solutions

```bash
# Run both parts of a day
mix aoc.solve 1

# Run only Part 1 (useful while working on it)
mix aoc.solve 1 -p 1
mix aoc.solve 1 --part 1

# Run only Part 2 (after Part 1 is complete)
mix aoc.solve 1 -p 2
```

### Testing Individual Parts

You can run specific tests to verify each part separately:

```bash
# Run all tests for a day
mix test test/days/day01_test.exs

# Run only the Part 1 test (using line number)
mix test test/days/day01_test.exs:7

# Run only the Part 2 test (using line number)
mix test test/days/day01_test.exs:13
```

### Programmatic Access

You can also run solutions from IEx or other Elixir code:

```elixir
# In IEx (iex -S mix)
AOC.solve_part(1, 1)   # Run day 1, part 1
AOC.solve_part(1, 2)   # Run day 1, part 2
AOC.solve_day(1)       # Run both parts

# Or call directly
AOC.Days.Day01.part1(AOC.read_input(1))
AOC.Days.Day01.part2(AOC.read_input(1))
```

## Utility Functions

The `AOC` module provides helpful utilities:

```elixir
# Read input files
AOC.read_input(1)           # Read inputs/day01/input.txt
AOC.read_input(1, :example) # Read inputs/day01/example.txt
AOC.read_lines(1)           # Read and split into lines

# Run solutions
AOC.solve_part(1, 1)        # Run day 1, part 1
AOC.solve_part(1, 2)        # Run day 1, part 2
AOC.solve_day(1)            # Run both parts of day 1

# Time a function
AOC.time(fn -> expensive_computation() end)
```

## Example Solution

```elixir
defmodule AOC.Days.Day01 do
  def part1(input) do
    input
    |> parse()
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> parse()
    |> Enum.product()
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def solve do
    input = AOC.read_input(1)
    IO.puts("Day 1 - Part 1: #{part1(input)}")
    IO.puts("Day 1 - Part 2: #{part2(input)}")
  end
end
```

## Running Tests

```bash
# Run all tests
mix test

# Run tests for specific day
mix test test/days/day01_test.exs

# Run with verbose output
mix test --trace
```

## Development

```bash
# Compile the project
mix compile

# Format code
mix format

# Run interactive shell
iex -S mix
```

## Try It Out

Day 1 is already scaffolded with a simple example to demonstrate the workflow:

```bash
# Run tests (should pass)
mix test test/days/day01_test.exs

# Run just Part 1
mix aoc.solve 1 -p 1

# Run just Part 2
mix aoc.solve 1 -p 2

# Run both parts
mix aoc.solve 1
```

The example solution sums and multiplies numbers - replace it with your actual Advent of Code solution when ready!

