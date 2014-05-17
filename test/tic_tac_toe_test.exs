defmodule TicTacToeTest do
  use ExUnit.Case

  test "cannot place the same token consecutively" do
    grid = %TicTacToe.Grid{ turns: 1 }

    assert {:error, "out of turn token"} = TicTacToe.place(grid, TicTacToe.X, 0)
  end

  test "cannot place a token on an unoccupied cell" do
    grid = %TicTacToe.Grid{cells: [nil, TicTacToe.X]}

    assert {:error, "cell is occupied"} = TicTacToe.place(grid, TicTacToe.X, 1)
  end

  test "increments number of turns" do
    grid = %TicTacToe.Grid{}

    assert {:ok, grid} = TicTacToe.place(grid, TicTacToe.X, 1)
    assert grid.turns == 1
  end

  test "places token in the right grid cell" do
    grid = %TicTacToe.Grid{}

    assert {:ok, grid} = TicTacToe.place(grid, TicTacToe.X, 4)
    assert grid.cells == [nil, nil, nil, nil, TicTacToe.X, nil, nil, nil, nil]
  end

  test "has no winner" do
    grid = %TicTacToe.Grid{
      cells: [
        TicTacToe.Y, TicTacToe.X, TicTacToe.Y,
        TicTacToe.X, TicTacToe.Y, TicTacToe.Y,
        TicTacToe.X, TicTacToe.X, nil
      ]
    }

    assert nil == TicTacToe.winner(grid)
  end

  test "Y is horizontal winner" do
    grid = %TicTacToe.Grid{
      cells: [
        nil,         nil,         nil,
        nil,         TicTacToe.X, TicTacToe.X,
        TicTacToe.Y, TicTacToe.Y, TicTacToe.Y,
      ]
    }

    assert TicTacToe.Y == TicTacToe.winner(grid)
  end

  test "X is vertical winner" do
    grid = %TicTacToe.Grid{
      cells: [
        nil,         TicTacToe.X, TicTacToe.Y,
        TicTacToe.Y, TicTacToe.X, TicTacToe.X,
        nil,         TicTacToe.X, TicTacToe.Y
      ]
    }

    assert TicTacToe.X == TicTacToe.winner(grid)
  end

  test "X is diagonal winner" do
    grid = %TicTacToe.Grid{
      cells: [
        TicTacToe.Y, nil,         TicTacToe.X,
        TicTacToe.Y, TicTacToe.X, TicTacToe.Y,
        TicTacToe.X, TicTacToe.X, nil
      ]
    }

    assert TicTacToe.X == TicTacToe.winner(grid)
  end
end
