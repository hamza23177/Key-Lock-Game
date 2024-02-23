import 'package:flutter/material.dart';
import 'dart:math';

class Structure {
  late List<List<int>> grid;
  int numRows = 5;
  int numColumns = 4;
  late int numKeys;
  late int numLocks;
  late int numObstacles;
  late bool gameStarted;

  void startNewGame() {
    numKeys = 1; // Change this to the desired number of keys
    numLocks = numKeys; // Set the number of locks equal to the number of keys
    numObstacles = 1; // Change this to the desired number of obstacles
    gameStarted = false;

    // Initialize grid with all cells set to 0 (empty)
    grid = List.generate(numRows, (_) => List.filled(numColumns, 0));

    // grid 1
    grid[0][0] = 2; // Manually placing a key
    grid[3][1] = 2; // Manually placing a key

    grid[0][2] = 3; // Manually placing a lock
    grid[2][3] = 3; // Manually placing a lock

    grid[0][1] = 1; // Manually placing an obstacle
    grid[2][0] = 1; // Manually placing an obstacle
    grid[2][1] = 1; // Manually placing an obstacle

    // grid 2
    // grid[0][1] = 2; // Manually placing a key
    // grid[0][3] = 2;
    // grid[1][6] = 2;
    // grid[3][4] = 2;
    //
    // grid[0][5] = 3; // Manually placing a lock
    // grid[4][2] = 3;
    // grid[4][5] = 3;
    // grid[2][0] = 3;
    //
    // grid[1][5] = 1; // Manually placing an obstacle
    // grid[2][2] = 1;
    // grid[3][5] = 1;
    // grid[4][4] = 1;
    // grid[5][2] = 1;

    // Place keys randomly on the grid
    placeItems(numKeys, 2);

    // Place locks randomly on the grid
    placeItems(numLocks, 3);

    // Place obstacles randomly on the grid
    placeItems(numObstacles, 1);
  }

  void placeItems(int count, int itemValue) {
    for (var i = 0; i < count; i++) {
      int row, col;
      do {
        row = Random().nextInt(numRows);
        col = Random().nextInt(numColumns);
      } while (grid[row][col] != 0);
      grid[row][col] = itemValue;
    }
  }

  Color getColor(int cell) {
    switch (cell) {
      case 0:
        return Colors.white;
      case 1:
        return Colors.grey;
      case 2:
        return Colors.yellow;
      case 3:
        return Colors.orange;
      default:
        return Colors.white;
    }
  }

  void moveKeys(int dx, int dy) {
    // Move the keys only if the game has started
    if (!gameStarted) {
      gameStarted = true;
      return;
    }

    List<int> keyRows = [];
    List<int> keyCols = [];

    // Find the positions of all the keys
    for (var i = 0; i < grid.length; i++) {
      for (var j = 0; j < grid[i].length; j++) {
        if (grid[i][j] == 2) {
          keyRows.add(i);
          keyCols.add(j);
        }
      }
    }

    // Check if the move is valid and update the positions of the keys
    for (var i = 0; i < keyRows.length; i++) {
      int keyRow = keyRows[i];
      int keyCol = keyCols[i];

      int newRow = keyRow + dy;
      int newCol = keyCol + dx;

      // Check if the new position is a valid and empty cell
      if (isValidPosition(newRow, newCol) && grid[newRow][newCol] == 0) {
        // Move the key to the new position
        grid[keyRow][keyCol] = 0;
        grid[newRow][newCol] = 2;
      }

      // Check if the new position has a lock and remove the key if it does
      if (isValidPosition(newRow, newCol) && grid[newRow][newCol] == 3) {
        // Remove the key and the lock from the grid
        grid[keyRow][keyCol] = 0;
        grid[newRow][newCol] = 0;
        numKeys--;
        numLocks--;

        // Check if all keys and locks have been matched
        if (numKeys == 0 && numLocks == 0) {
          //print('😍😍 Winnneeeer 😍😍');
          return;
        }
      }
    }
  }

  bool isValidPosition(int row, int col) {
    return row >= 0 && row < numRows && col >= 0 && col < numColumns;
  }

  bool isGoalState() {
    for (var i = 0; i < grid.length; i++) {
      for (var j = 0; j < grid[i].length; j++) {
        if (grid[i][j] == 2 || grid[i][j] == 3) {
          return false;
        }
      }
    }
    return true;
  }

  List<List<int>> getFinalState() {
    List<List<int>> finalState = [];
    for (var i = 0; i < grid.length; i++) {
      List<int> row = [];
      for (var j = 0; j < grid[i].length; j++) {
        if (grid[i][j] == 2 || grid[i][j] == 3) {
          row.add(0);
        } else {
          row.add(grid[i][j]);
        }
      }
      finalState.add(row);
    }
    //print(finalState);
    return finalState;
  }

  Structure deepCopyStructure(Structure original) {
    Structure copy = Structure();
    copy.numRows = original.numRows;
    copy.numColumns = original.numColumns;
    copy.numKeys = original.numKeys;
    copy.numLocks = original.numLocks;
    copy.numObstacles = original.numObstacles;
    copy.gameStarted = original.gameStarted;

    copy.grid = List.generate(original.numRows, (index) {
      return List<int>.from(original.grid[index]);
    });

    return copy;
  }

  List<Structure> generateNextStates(Structure currentState) {
    List<Structure> nextStates = [];

    for (int dx = -1; dx <= 1; dx++) {
      for (int dy = -1; dy <= 1; dy++) {
        if (dx != 0 || dy != 0) {
          Structure newState = deepCopyStructure(currentState);
          newState.moveKeys(dx, dy); // Update the state with the new move
          nextStates.add(newState);
        }
      }
    }

    return nextStates;
  }

  bool check_move(int dx, int dy) {
    for (var i = 0; i < grid.length; i++) {
      for (var j = 0; j < grid[i].length; j++) {
        if (grid[i][j] == 2) {
          int newRow = i + dy;
          int newCol = j + dx;

          // Check if the move is within bounds and to an empty cell
          if (isValidPosition(newRow, newCol) && grid[newRow][newCol] == 0) {
            return true;
          }
        }
      }
    }
    return false;
  }

  void print_move(int dx, int dy) {
    if (check_move(dx, dy)) {
      print('Valid move: ($dx, $dy)');
    } else {
      print('Invalid move: ($dx, $dy)');
    }
  }

  bool able_to_move() {
    for (var i = 0; i < grid.length; i++) {
      for (var j = 0; j < grid[i].length; j++) {
        if (grid[i][j] == 2) {
          // Check if any move is valid for at least one key
          for (var dx = -1; dx <= 1; dx++) {
            for (var dy = -1; dy <= 1; dy++) {
              if (dx != 0 || dy != 0) {
                if (isValidPosition(i + dy, j + dx) &&
                    grid[i + dy][j + dx] == 0) {
                  return true;
                }
              }
            }
          }
        }
      }
    }
    return false;
  }

  List<Structure> get_next_states() {
    List<Structure> nextStates = [];
    for (var i = 0; i < grid.length; i++) {
      for (var j = 0; j < grid[i].length; j++) {
        if (grid[i][j] == 2) {
          for (var dx = -1; dx <= 1; dx++) {
            for (var dy = -1; dy <= 1; dy++) {
              if (dx != 0 || dy != 0) {
                if (isValidPosition(i + dy, j + dx) &&
                    grid[i + dy][j + dx] == 0) {
                  Structure newState = deepCopyStructure(this);
                  newState.moveKeys(dx, dy); // Move the keys
                  nextStates.add(newState);
                }
              }
            }
          }
        }
      }
    }
    return nextStates;
  }

  int manhattanHeuristic(
      List<List<int>> currentState, List<List<int>> goalState) {
    int heuristicValue = 0;
    for (int i = 0; i < currentState.length; i++) {
      for (int j = 0; j < currentState[i].length; j++) {
        int value = currentState[i][j];
        if (value != 0) {
          double targetI = (value - 1) / currentState.length;
          int targetJ = (value - 1);
          heuristicValue += ((i - targetI).abs() + (j - targetJ).abs()) as int;
        }
      }
    }
    return heuristicValue;
  }
}
