import 'package:flutter/material.dart';
import 'calculator_controller.dart';
import 'converter_screen.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorController controller = CalculatorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic Calculator'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.sync_alt),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConverterScreen()),
              );
            },
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.bottomRight,
                child: Text(
                  controller.displayText,
                  style: TextStyle(fontSize: 60, color: Colors.white),
                ),
              ),
            ),
            GridView.count(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
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
                    onPressed: () => setState(() {
                      controller
                          .inputCharacter(key);
                    }),
                    child: Text(key,
                        style: TextStyle(fontSize: 24, color: Colors.white)),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[850],
                      foregroundColor: Colors.white,
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
