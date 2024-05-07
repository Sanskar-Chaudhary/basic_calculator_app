import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Calculator',
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Display area for calculator
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.bottomRight,
                child: Text(
                  '0',
                  style: TextStyle(fontSize: 60, color: Colors.white),
                ),
              ),
            ),
            // Button area for calculator
            GridView.count(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              // to disable GridView's scrolling
              children: <String>[
                'AC',
                '%',
                '×',
                '÷',
                '7',
                '8',
                '9',
                '-',
                '4',
                '5',
                '6',
                '+',
                '1',
                '2',
                '3',
                '=',
                '00',
                '0',
                '.',
              ].map((key) {
                return GridTile(
                  child: TextButton(
                    onPressed: () {}, // We will add functionality later
                    child: Text(key,
                        style: TextStyle(fontSize: 24, color: Colors.white)),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[850],
                      foregroundColor: Colors.white,
                      // Correct property for text color
                      shape: CircleBorder(),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
