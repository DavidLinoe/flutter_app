import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 5.5,
          children: [
            InputChip(
              label: Text('Input Chip'),
              onPressed: () => _incrementCounter(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              spacing: 5.5,
              children: [
                for (var calc in [
                  {"label": '1', "value": 1},
                  {"label": '2', "value": 2},
                  {"label": '3', 'value': 3},
                ])
                  ElevatedButton(
                    onPressed: () => _incrementCounter(),
                    child: Text(calc['label']! as String),
                  ),
              ],
            ),
            Row(
              spacing: 5.5,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                for (var calc in [
                  {"label": '4', "value": 4},
                  {"label": '5', "value": 5},
                  {"label": '6', 'value': 6},
                ])
                  ElevatedButton(
                    onPressed: () => _incrementCounter(),
                    child: Text(calc['label']! as String),
                  ),
              ],
            ),
            Row(
              spacing: 5.5,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                for (var calc in [
                  {"label": '7', "value": 7},
                  {"label": '8', "value": 8},
                  {"label": '9', 'value': 9},
                ])
                  ElevatedButton(
                    onPressed: () => _incrementCounter(),
                    child: Text(calc['label']! as String),
                  ),
              ],
            ),
            Row(
              spacing: 5.5,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var calc in [
                  {"label": '+', "value": 7},
                  {"label": '-', "value": 8},
                  {"label": '*', 'value': 9},
                ])
                  ElevatedButton(
                    onPressed: () => _incrementCounter(),
                    child: Text(calc['label']! as String),
                  ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
