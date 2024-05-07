import 'package:flutter/material.dart';

class ConverterScreen extends StatefulWidget {
  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final TextEditingController _kmController = TextEditingController();
  final TextEditingController _milesController = TextEditingController();
  bool isKmActive = true; // Track which input is active

  void _convertKmToMiles(String km) {
    final double kilometers = double.parse(km);
    final double miles = kilometers * 0.621371;
    _milesController.text = miles.toStringAsFixed(4);
  }

  void _convertMilesToKm(String miles) {
    final double milesValue = double.parse(miles);
    final double kilometers = milesValue / 0.621371;
    _kmController.text = kilometers.toStringAsFixed(4);
  }

  void _handleInput(String input) {
    if (isKmActive) {
      _kmController.text += input;
      _convertKmToMiles(_kmController.text);
    } else {
      _milesController.text += input;
      _convertMilesToKm(_milesController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Length Conversion', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _milesController,
                  decoration: InputDecoration(
                    labelText: 'Mile (mi)',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  style: TextStyle(fontSize: 24, color: Colors.white),
                  textAlign: TextAlign.center,
                  onTap: () => setState(() {
                    isKmActive = false;
                  }),
                  keyboardType: TextInputType.none,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _kmController,
                  decoration: InputDecoration(
                    labelText: 'Kilometre (km)',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  style: TextStyle(fontSize: 24, color: Colors.white),
                  textAlign: TextAlign.center,
                  onTap: () => setState(() {
                    isKmActive = true;
                  }),
                  keyboardType: TextInputType.none,
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey),
          _buildNumberPad(),
        ],
      ),
    );
  }

  Widget _buildNumberPad() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.black,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ['7', '8', '9']
                .map((number) => _buildNumberButton(number))
                .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ['4', '5', '6']
                .map((number) => _buildNumberButton(number))
                .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ['1', '2', '3']
                .map((number) => _buildNumberButton(number))
                .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ['AC', '0', '.']
                .map((number) => _buildNumberButton(number))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[850], // Use backgroundColor for the button's background color.
            foregroundColor: Colors.white, // Use foregroundColor for text and icon color.
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onPressed: () {
            setState(() {
              if (number == 'AC') {
                // Clear the corresponding text field
                if (isKmActive) {
                  _kmController.clear();
                  _milesController.clear();
                } else {
                  _milesController.clear();
                  _kmController.clear();
                }
              } else {
                // Add number to the corresponding text field
                _handleInput(number);
              }
            });
          },
          child: Text(number,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
