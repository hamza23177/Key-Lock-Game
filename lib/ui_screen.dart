import 'package:flutter/material.dart';
import 'package:untitled3/structure.dart';

Structure str = Structure();

class ResultAlgo extends StatelessWidget {
  final List<List<int>> path;
  final String algoName;
  final int time;
  const ResultAlgo(
      {super.key,
      required this.path,
      required this.algoName,
      required this.time});

  @override
  Widget build(BuildContext context) {
    print('path : $path');
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Algo: ${algoName} , path length: ${path.length} , time: ${time} ms '),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
          child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: SafeArea(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Algo: ${algoName} , path length: ${path.length} , time: ${time} ms ',
                ),
              )),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'the path is: ${path}',
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
