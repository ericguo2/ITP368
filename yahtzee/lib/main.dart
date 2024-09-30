import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(Yahtzee());
}

class Yahtzee extends StatelessWidget {
  const Yahtzee({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "yahtzee",
      home: YahtzeeHome(),
    );
  }
}

class YahtzeeHome extends StatefulWidget {
  const YahtzeeHome({super.key});

  @override
  State<YahtzeeHome> createState() => YahtzeeHomeState();
}

class YahtzeeHomeState extends State<YahtzeeHome> {
  final Random random = Random();
  List<int> diceValues = [1, 1, 1, 1, 1]; // Initial values for 5 dice
  List<bool> holdStatus = [false, false, false, false, false]; // Track held dice

  // Function to roll the dice (but skip held dice)
  void rollDice() {
    setState(() {
      for (int i = 0; i < diceValues.length; i++) {
        if (!holdStatus[i]) {
          diceValues[i] = random.nextInt(6) + 1; // Random number between 1 and 6
        }
      }
    });
  }

  // Toggle hold status for a specific die
  void toggleHold(int index) {
    setState(() {
      holdStatus[index] = !holdStatus[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Yahtzee")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (index) {
              return Column(
                children: [
                  Text(
                    '${diceValues[index]}', // Display dice value
                    style: const TextStyle(fontSize: 40, color: Colors.black),
                  ),
                  ElevatedButton(
                    onPressed: () => toggleHold(index),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          holdStatus[index] ? Colors.red : Colors.green,
                    ),
                    child: Text(holdStatus[index] ? 'Held' : 'Hold'),
                  ),
                ],
              );
            }),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: rollDice,
            child: const Text("Roll Dice"),
          ),
        ],
      ),
    );
  }
}
