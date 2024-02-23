import 'dart:collection';
import 'package:untitled3/structure.dart';
import 'package:collection/collection.dart';
import 'dart:math';

class Logic {
  // BFS Algorithm

  void bfsAlgorithm(Structure initialState) {
    Queue<Structure> queue = Queue();
    Set<Structure> visited = Set();
    List<Structure> path = [];

    queue.add(initialState);
    visited.add(initialState);

    while (queue.isNotEmpty) {
      Structure current = queue.removeFirst();
      visited.add(current);
      path.add(current);

      if (current.isGoalState()) {
        print('🎉🎉 Congratulations! You have reached the goal! BFS 🎉🎉');
        List<List<int>> finalState = current.getFinalState();
        // Print final state
        print(finalState);
        // Print number of visited nodes
        print('Number of visited nodes: ${path.length}');
        break;
      }

      // Generate next states
      List<Structure> nextStates = initialState.generateNextStates(current);

      for (Structure nextState in nextStates) {
        if (!visited.contains(nextState)) {
          queue.add(nextState);
          visited.add(nextState);
        }
      }
    }
  }

  // DFS Algorithm

  void dfsAlgorithm(Structure initialState) {
    Queue<Structure> stack = Queue();
    Set<Structure> visited = {};

    stack.add(initialState);
    visited.add(initialState);

    while (stack.isNotEmpty) {
      Structure current = stack.removeLast();

      if (current.isGoalState()) {
        print('🎉🎉 Congratulations! You have reached the goal! DFS 🎉🎉');
        List<List<int>> finalState = current.getFinalState();
        // Print final state
        print(finalState);
        // Print number of visited nodes
        print('Number of visited nodes: ${visited.length}');
        break;
      }

      // Apply possible moves and enqueue new states
      List<Structure> nextStates = initialState.generateNextStates(current);

      for (Structure nextState in nextStates) {
        if (!visited.contains(nextState)) {
          stack.add(nextState);
          visited.add(nextState);
        }
      }
    }
  }

  // UCS Algorithm

  void ucsAlgorithm(Structure initialState) {
    PriorityQueue<StructureCostPair> priorityQueue =
        PriorityQueue((a, b) => a.cost.compareTo(b.cost));
    Map<Structure, int> costSoFar = {initialState: 0};

    priorityQueue.add(StructureCostPair(structure: initialState, cost: 0));

    while (priorityQueue.isNotEmpty) {
      var currentPair = priorityQueue.removeFirst();
      Structure current = currentPair.structure;

      if (current.isGoalState()) {
        print('🎉🎉 Congratulations! You have reached the goal! UCS🎉🎉');
        List<List<int>> finalState = current.getFinalState();
        // Print final state
        print(finalState);
        // Print cost
        print('Cost: ${currentPair.cost}');
        break;
      }

      // Apply possible moves and enqueue new states
      for (int dx = -1; dx <= 1; dx++) {
        for (int dy = -1; dy <= 1; dy++) {
          if (dx != 0 || dy != 0) {
            Structure newState = initialState.deepCopyStructure(current);
            newState.moveKeys(dx, dy);
            int newCost = currentPair.cost + (dx.abs() + dy.abs() == 1 ? 1 : 2);

            if (!costSoFar.containsKey(newState) ||
                newCost < costSoFar[newState]!) {
              costSoFar[newState] = newCost;
              priorityQueue
                  .add(StructureCostPair(structure: newState, cost: newCost));
            }
          }
        }
      }
    }
  }

  // Hill_Cilmbing Algorithm

  void hillClimbingAlgorithm(Structure initialState) {
    Structure current = initialState;
    int currentCost = manhattanHeuristic(
        current as List<List<int>>, current.isGoalState() as List<List<int>>);
    while (true) {
      List<Structure> nextStates = initialState.generateNextStates(current);
      Structure? nextState;
      int minCost = currentCost;

      for (Structure state in nextStates) {
        int cost = manhattanHeuristic(
            state as List<List<int>>, current.isGoalState() as List<List<int>>);
        if (cost < minCost) {
          nextState = state;
          minCost = cost;
        }
      }
      if (nextState == null || minCost >= currentCost) {
        print(
            '🎉🎉 Congratulations! You have reached the goal! Hill Climbing 🎉🎉');
        // Print final state
        List<List<int>> finalState = current.getFinalState();
        print(finalState);
        // Print cost
        print('Cost: currentCost');
        break;
      }
      current = nextState;
      currentCost = minCost;
    }
  }

  //A* Algorithm

  void astarAlgorithm(Structure initialState, Function heuristicFunction) {
    PriorityQueue<StructureCostPair> priorityQueue =
        PriorityQueue((a, b) => a.cost.compareTo(b.cost));
    Map<Structure, int> costSoFar = {initialState: 0};

    priorityQueue.add(StructureCostPair(structure: initialState, cost: 0));

    while (priorityQueue.isNotEmpty) {
      var currentPair = priorityQueue.removeFirst();
      Structure current = currentPair.structure;

      if (current.isGoalState()) {
        print('🎉🎉 Congratulations! You have reached the goal! UCS🎉🎉');
        List<List<int>> finalState = current.getFinalState();
        // Print final state
        print(finalState);
        // Print cost
        print('Cost: ${currentPair.cost}');
        break;
      }

      // Apply possible moves and enqueue new states
      for (int dx = -1; dx <= 1; dx++) {
        for (int dy = -1; dy <= 1; dy++) {
          if (dx != 0 || dy != 0) {
            Structure newState = initialState.deepCopyStructure(current);
            newState.moveKeys(dx, dy);
            int heuristicFunction =
                currentPair.cost + (dx.abs() + dy.abs() == 1 ? 1 : 2);

            if (!costSoFar.containsKey(newState) ||
                heuristicFunction < costSoFar[newState]!) {
              costSoFar[newState] = heuristicFunction;
              priorityQueue.add(StructureCostPair(
                  structure: newState, cost: heuristicFunction));
            }
          }
        }
      }
    }
  }

  // Three Heuristic function

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

  // إقليدية
  int euclideanHeuristic(
      List<List<int>> currentState, List<List<int>> goalState) {
    int heuristicValue = 0;
    for (int i = 0; i < currentState.length; i++) {
      for (int j = 0; j < currentState[i].length; j++) {
        int value = currentState[i][j];
        if (value != 0) {
          double targetI = (value - 1) / currentState.length;
          int targetJ = (value - 1);
          heuristicValue +=
              sqrt(pow(i - targetI, 2) + pow(j - targetJ, 2)).toInt();
        }
      }
    }
    return heuristicValue;
  }

  int misplacedTilesHeuristic(
      List<List<int>> currentState, List<List<int>> goalState) {
    int heuristicValue = 0;
    for (int i = 0; i < currentState.length; i++) {
      for (int j = 0; j < currentState.length; j++) {
        if (currentState[i][j] != goalState[i][j]) {
          heuristicValue++;
        }
      }
    }
    return heuristicValue;
  }
}

class StructureCostPair {
  Structure structure;
  int cost;
  StructureCostPair({required this.structure, required this.cost});
}
