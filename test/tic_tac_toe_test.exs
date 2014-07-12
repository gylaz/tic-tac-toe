defmodule TicTacToeTest do
  use ExUnit.Case

  test "cannot place the same token consecutively" do
    grid = %TicTacToe.Grid{ turns: 1 }

    assert {:error, "out of turn token"} = TicTacToe.place(grid, :x, 0)
  end

  test "cannot place a token on an unoccupied cell" do
    grid = %TicTacToe.Grid{cells: [nil, :x]}

    assert {:error, "cell is occupied"} = TicTacToe.place(grid, :x, 1)
  end

  test "increments number of turns" do
    grid = %TicTacToe.Grid{}

    assert {:ok, grid} = TicTacToe.place(grid, :x, 1)
    assert grid.turns == 1
  end

  test "places token in the right grid cell" do
    grid = %TicTacToe.Grid{}

    assert {:ok, grid} = TicTacToe.place(grid, :x, 4)
    assert grid.cells == [nil, nil, nil, nil, :x, nil, nil, nil, nil]
  end

  test "has no winner" do
    grid = %TicTacToe.Grid{
      cells: [
        :y, :x, :y,
        :x, :y, :y,
        :x, :x, nil
      ]
    }

    assert nil == TicTacToe.winner(grid)
  end

  test "Y is horizontal winner" do
    grid = %TicTacToe.Grid{
      cells: [
        nil, nil, nil,
        nil,  :x,  :x,
         :y,  :y,  :y,
      ]
    }

    assert :y == TicTacToe.winner(grid)
  end

  test "X is vertical winner" do
    grid = %TicTacToe.Grid{
      cells: [
        nil, :x, :y,
         :y, :x, :x,
        nil, :x, :y
      ]
    }

    assert :x == TicTacToe.winner(grid)
  end

  test "X is diagonal winner" do
    grid = %TicTacToe.Grid{
      cells: [
        :y, nil,:x,
        :y, :x, :y,
        :x, :x, nil
      ]
    }

    assert :x == TicTacToe.winner(grid)
  end
end
