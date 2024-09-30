import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(LightsOutApp());
}

class LightsOutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lights Out',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LightsOutHomePage(),
    );
  }
}

class LightsOutHomePage extends StatefulWidget {
  @override
  _LightsOutHomePageState createState() => _LightsOutHomePageState();
}

class _LightsOutHomePageState extends State<LightsOutHomePage> {
  int numberOfLights = 5; // Default N
  List<bool> lights = [];

  @override
  void initState() {
    super.initState();
    _initializeLights();
  }

  void _initializeLights() {
    lights = List.generate(numberOfLights, (_) => Random().nextBool());
  }

  void _flipLight(int index) {
    setState(() {
      // Flip the selected light
      lights[index] = !lights[index];

      // Flip the left neighbor if exists
      if (index > 0) {
        lights[index - 1] = !lights[index - 1];
      }

      // Flip the right neighbor if exists
      if (index < numberOfLights - 1) {
        lights[index + 1] = !lights[index + 1];
      }
    });
  }

  bool _checkIfWon() {
    return lights.every((light) => !light); // All lights off
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lights Out'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Input for number of lights (N)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Enter number of lights',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (value) {
                setState(() {
                  numberOfLights = int.tryParse(value) ?? 5;
                  _initializeLights();
                });
              },
            ),
          ),
          // Display lights
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(numberOfLights, (index) {
              return IconButton(
                icon: Icon(
                  lights[index] ? Icons.lightbulb : Icons.lightbulb_outline,
                  color: lights[index] ? Colors.yellow : Colors.grey,
                ),
                onPressed: () => _flipLight(index),
              );
            }),
          ),
          // Winning condition
          if (_checkIfWon())
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'You Won!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
          
        ],
      ),
    );
  }
}
