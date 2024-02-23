import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/logic.dart';

import 'package:untitled3/structure.dart';
import 'package:untitled3/ui_screen.dart';

Structure str = Structure();
Logic log = Logic();

void main() {
  runApp(const MaterialApp(
    home: KeyLockGame(),
  ));
}

class KeyLockGame extends StatefulWidget {
  const KeyLockGame({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _KeyLockGameState createState() => _KeyLockGameState();
}

class _KeyLockGameState extends State<KeyLockGame> {
  @override
  void initState() {
    super.initState();
    setState(() {
      str.startNewGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Key Lock Game'),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: () {
                  setState(
                    () {
                      str.startNewGame();
                    },
                  );
                },
                backgroundColor: Colors.green,
                child: const Icon(Icons.refresh),
              ),
              SizedBox(
                width: 5.0,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(
                    () {
                      log.bfsAlgorithm(str);
                    },
                  );
                },
                child: Text('BFS'),
              ),
              SizedBox(
                width: 5.0,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(
                    () {
                      log.dfsAlgorithm(str);
                    },
                  );
                },
                child: Text('DFS'),
              ),
              SizedBox(
                width: 5.0,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(
                    () {
                      log.ucsAlgorithm(str);
                    },
                  );
                },
                child: Text('UCS'),
              ),
              SizedBox(
                width: 5.0,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(
                    () {
                      log.hillClimbingAlgorithm(str);
                    },
                  );
                },
                child: Text('Hill'),
              ),
            ],
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var row in str.grid)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var cell in row)
                    Container(
                      margin: const EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width / str.numColumns,
                      height:
                          MediaQuery.of(context).size.width / str.numColumns,
                      color: str.getColor(cell),
                      alignment: Alignment.center,
                      // child: Text(
                      //   cell.toString(),
                      //   style: TextStyle(
                      //     fontSize: MediaQuery.of(context).size.width /
                      //         (2 * str.numColumns),
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                    ),
                ],
              ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                str.moveKeys(0, -1);
              });
            },
            child: const Icon(Icons.arrow_upward),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    str.moveKeys(-1, 0);
                  });
                },
                child: const Icon(Icons.arrow_back),
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    str.moveKeys(1, 0);
                  });
                },
                child: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                str.moveKeys(0, 1);
              });
            },
            child: const Icon(Icons.arrow_downward),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        //shape: CircularNotchedRectangle(),
        child: Container(
          height: 125.0,
        ),
      ),
    );
  }
}
