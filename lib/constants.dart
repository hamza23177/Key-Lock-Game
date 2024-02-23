//heuridtic =17
//cost=28 A*
//children = 37

// Future<void> showGameEndDialog() async {
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('Congratulations!'),
//         content: const SingleChildScrollView(
//           child: ListBody(
//             children: <Widget>[
//               Text('You have unlocked all the locks.'),
//               Text('Do you want to play again?'),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('Yes'),
//             onPressed: () {
//               startNewGame();
//               Navigator.of(context).pop();
//             },
//           ),
//           TextButton(
//             child: const Text('No'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }

// List<List<int>> getFinalState() {
//   List<List<int>> finalState = [];
//   for (var i = 0; i < grid.length; i++) {
//     List<int> row = [];
//     for (var j = 0; j < grid[i].length; j++) {
//       if (grid[i][j] == 1 ) {
//         row.add(grid[i][j]);
//       } else {
//         row.add(0); // If not a final state, set to 0
//       }
//     }
//     finalState.add(row);
//   }
//   return finalState;
// }

// List<List<int>> getKeyLocations(List<List<int>> grid) {
//   List<List<int>> keyLocations = [];
//   for (int i = 0; i < grid.length; i++) {
//     for (int j = 0; j < grid[i].length; j++) {
//       // ignore: unrelated_type_equality_checks
//       if (grid[i][j] == 2) {
//         keyLocations.add([i, j]);
//       }
//     }
//   }
//   return keyLocations;
// }
// grid[0][2] = 2; // Manually placing a key
// //grid[1][0] = 2; // Manually placing a key
// //grid[1][4] = 2; // Manually placing a key
// grid[4][0] = 3; // Manually placing a lock
// //grid[3][3] = 3; // Manually placing a lock
// // grid[5][2] = 3; // Manually placing a lock
// grid[2][0] = 1; // Manually placing an obstacle
// grid[1][1] = 1; // Manually placing an obstacle
// grid[1][3] = 1; // Manually placing an obstacle


// void bfs(Structure startState) {
//   Queue<Structure> queue = Queue();
//   Set<Structure> visited = Set();
//
//   queue.add(startState);
//   visited.add(startState);
//
//   while (queue.isNotEmpty) {
//     Structure currentState = queue.removeFirst();
//
//     if (currentState.isGoalState()) { // يجب عليك إنشاء دالة isGoalState() مناسبة
//       print("Goal state found!");
//       print("Number of nodes visited: ${visited.length}");
//       print("Path: "); // يجب عليك إنشاء دالة getPath() مناسبة وتطبيقها هنا
//       return;
//     }
//
//     List<Structure> nextStates = generateNextStates(currentState);
//
//     for (Structure nextState in nextStates) {
//       if (!visited.contains(nextState)) {
//         queue.add(nextState);
//         visited.add(nextState);
//       }
//     }
//   }
//
//   print("Goal state not found!");
// }


//

// import 'dart:collection';
// import 'package:untitled3/structure.dart';
// import 'package:collection/collection.dart';
//
// class Logic {
//   int numOfVisitedNodes = 0;
//
//   //DFS Algorithm
//   List<List<int>> dfsAlgorithm(Structure str) {
//     List<List<int>> visited = List.generate(
//       str.grid.length,
//           (index) => List.filled(str.grid[0].length, 0),
//     );
//     List<List<int>> path = [];
//     Queue<List<int>> stack = Queue();
//     stack.add(str.grid.first);
//
//     while (stack.isNotEmpty) {
//       List<int> current = stack.removeLast();
//       numOfVisitedNodes++;
//       int row = current[0];
//       int col = current[1];
//
//       if (row < 0 ||
//           row >= str.grid.length ||
//           col < 0 ||
//           col >= str.grid[0].length ||
//           visited[row][col] == 1) {
//         continue;
//       }
//
//       path.add([row, col]);
//       visited[row][col] = 1;
//
//       if (str.grid[row][col] == 3) {
//         print(path);
//         print('solved DFS');
//         print('number df visit node in DFS : $numOfVisitedNodes');
//         return path;
//       }
//
//       stack.add([row + 1, col]);
//       stack.add([row - 1, col]);
//       stack.add([row, col + 1]);
//       stack.add([row, col - 1]);
//     }
//
//     return [];
//   }
//
//   //BFS Algorithm
//   List<List<int>> bfsAlgorithm(Structure str) {
//     List<List<int>> visited = List.generate(
//         str.grid.length, (index) => List.filled(str.grid[0].length, 0));
//     List<List<int>> path = [];
//     Queue<List<int>> queue = Queue();
//     queue.add(str.grid.first);
//
//     while (queue.isNotEmpty) {
//       List<int> current = queue.removeFirst();
//       numOfVisitedNodes++;
//       int row = current[0];
//       int col = current[1];
//
//       if (row < 0 ||
//           row >= str.grid.length ||
//           col < 0 ||
//           col >= str.grid[0].length ||
//           visited[row][col] == 1) {
//         continue;
//       }
//
//       path.add([row, col]);
//       visited[row][col] = 1;
//
//       if (str.grid[row][col] == 3) {
//         print(path);
//         print('solved BFS');
//         print('number df visit node in BFS : $numOfVisitedNodes');
//         return path;
//       }
//
//       queue.add([row + 1, col]);
//       queue.add([row - 1, col]);
//       queue.add([row, col + 1]);
//       queue.add([row, col - 1]);
//     }
//
//     return [];
//   }
//
//   List<List<int>> ucsAlgorithm(Structure str) {
//     List<List<int>> visited = List.generate(
//         str.grid.length, (index) => List.filled(str.grid[0].length, 0));
//     List<List<int>> path = [];
//     PriorityQueue<List<int>> priorityQueue =
//     PriorityQueue((a, b) => a[2].compareTo(b[2]));
//     priorityQueue.add([...str.grid.first, 0]);
//
//     while (priorityQueue.isNotEmpty) {
//       List<int> current = priorityQueue.removeFirst();
//       numOfVisitedNodes++;
//       int row = current[0];
//       int col = current[1];
//       int cost = current[2];
//
//       if (row < 0 ||
//           row >= str.grid.length ||
//           col < 0 ||
//           col >= str.grid[0].length ||
//           visited[row][col] == 1) {
//         continue;
//       }
//
//       path.add([row, col]);
//       visited[row][col] = 1;
//
//       if (str.grid[row][col] == 3) {
//         print(path);
//         print('solved UCS');
//         print('the Cost is $cost');
//         print('number df visit node in UCS : $numOfVisitedNodes');
//         return path;
//       }
//
//       priorityQueue.add([row + 1, col, cost + 2]); // Move down with cost 2
//       priorityQueue.add([row - 1, col, cost + 1]); // Move up with cost 1
//       priorityQueue.add([row, col + 1, cost + 2]); // Move right with cost 2
//       priorityQueue.add([row, col - 1, cost + 1]); // Move left with cost 1
//     }
//
//     return [];
//   }
// }


// DFS important??

// List<Structure> dfs() {
//   Queue<Structure> stack = Queue();
//   Set<Structure> visited = Set();
//   List<Structure> path = [];
//
//   stack.add(this);
//   visited.add(this);
//
//   while (stack.isNotEmpty) {
//     Structure current = stack.removeLast();
//     path.add(current);
//
//     if (current.isGoalState()) {
//       break;
//     }
//
//     List<Structure> nextStates = generateNextStates(current);
//     for (var state in nextStates) {
//       if (!visited.contains(state)) {
//         stack.add(state);
//         visited.add(state);
//       }
//     }
//   }
//
//   print('Number of visited nodes: ${visited.length}');
//   print('Path: $path');
//   return path;
// }


//BFS  important



//move Function

// void moveLeft() {
//   moveKeys(-1, 0);
// }
//
// void moveRight() {
//   moveKeys(1, 0);
// }
//
// void moveUp() {
//   moveKeys(0, -1);
// }
//
// void moveDown() {
//   moveKeys(0, 1);
// }