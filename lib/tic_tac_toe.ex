defmodule TicTacToe do
  require Integer

  defmodule X do end
  defmodule Y do end

  defmodule Grid do
    defstruct turns: 0, cells: Enum.map(1..9, fn(_) -> nil end)
  end

  def place(%Grid{turns: turns}, X, _) when Integer.odd?(turns) do
    {:error, "out of turn token"}
  end

  def place(grid, token, position) do
    if nil?(Enum.fetch!(grid.cells, position)) do
      grid = %Grid{
        grid | turns: + 1, cells: List.replace_at(grid.cells, position, token)
      }

      {:ok, grid}
    else
      {:error, "cell is occupied"}
    end
  end

  def winner(grid) do
    rows = Enum.chunk(grid.cells, 3)
    columns = columns_from_grid(grid)
    diagonals = []

    winner_in_cells(rows) || winner_in_cells(columns) || winner_in_cells(diagonals)
  end

  defp winner_in_cells(cell_groups) do
    match = Enum.find(cell_groups, [], &winner_in_group/1)

    List.first(match)
  end

  defp winner_in_group(cell_group) do
    uniques = Enum.uniq(cell_group)
    Enum.count(uniques) == 1 and List.first(uniques)
  end

  defp columns_from_grid(grid) do
    Enum.map(0..2,
      fn(i) ->
        Enum.map(0..2, fn(j) -> Enum.at(grid.cells, i + j * 3) end)
      end
    )
  end
end
