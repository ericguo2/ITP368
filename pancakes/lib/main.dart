import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const PancakeSortingApp());
}

class PancakeSortingApp extends StatelessWidget {
  const PancakeSortingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pancake Sorting Game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const PancakeSortingHomePage(),
    );
  }
}

class PancakeSortingHomePage extends StatefulWidget {
  const PancakeSortingHomePage({super.key});

  @override
  State<PancakeSortingHomePage> createState() => _PancakeSortingHomePageState();
}

class _PancakeSortingHomePageState extends State<PancakeSortingHomePage> {
  List<int> _pancakes = [];
  List<int> _initialStack = [];
  int _numPancakes = 5;
  int _flipCount = 0;

  @override
  void initState() {
    super.initState();
    _generateNewPancakeStack();
  }

  // Generates a new stack and saves the initial state
  void _generateNewPancakeStack() {
    setState(() {
      _pancakes = List.generate(_numPancakes, (index) => index + 1);
      _pancakes.shuffle(Random());
      _initialStack = List.from(_pancakes); // Save the initial stack for retry
      _flipCount = 0;
    });
  }

  // Resets the stack to its initial state
  void _retryPancakeStack() {
    setState(() {
      _pancakes = List.from(_initialStack);
      _flipCount = 0;
    });
  }

  // Flip the pancakes from a selected index
  void _flip(int index) {
    setState(() {
      _pancakes = _pancakes.sublist(0, index + 1).reversed.toList() + _pancakes.sublist(index + 1);
      _flipCount++;
    });
  }

  // Increase the number of pancakes
  void _increasePancakes() {
    if (_numPancakes < 20) {
      setState(() {
        _numPancakes++;
        _generateNewPancakeStack();
      });
    }
  }

  // Decrease the number of pancakes
  void _decreasePancakes() {
    if (_numPancakes > 2) {
      setState(() {
        _numPancakes--;
        _generateNewPancakeStack();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pancake Sorting Game'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Number of Pancakes: $_numPancakes', style: Theme.of(context).textTheme.headlineMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _decreasePancakes,
                child: const Text('-'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _increasePancakes,
                child: const Text('+'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            children: _pancakes
                .asMap()
                .entries
                .map((entry) => GestureDetector(
                      onTap: () => _flip(entry.key),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        width: (entry.value * 20).toDouble(),
                        height: 30,
                        color: Colors.brown[(entry.value * 100) % 900],
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 20),
          Text('Flip Count: $_flipCount', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _generateNewPancakeStack,
                child: const Text('New Stack'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: _retryPancakeStack,
                child: const Text('Retry Stack'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
