import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sequence Explorer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Sequence Explorer Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';
  
  void _exploreSequence() {
    final int? start = int.tryParse(_controller.text);
    if (start != null && start > 0) {
      final explorer = SequenceExplorer(start);
      setState(() {
        _result =
            'Starting Number: $start\nSequence: ${explorer.sequence}\nMax Value: ${explorer.maxInSequence}\nSequence Length: ${explorer.sequenceLength}';
      });
    } else {
      setState(() {
        _result = 'Please enter a valid positive integer.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter a starting number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _exploreSequence,
              child: const Text('Explore Sequence'),
            ),
            const SizedBox(height: 16),
            Text(
              _result,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// SequenceExplorer class
class SequenceExplorer {
  final int start;
  final List<int> sequence;
  final int maxInSequence;
  final int sequenceLength;

  SequenceExplorer(this.start)
      : sequence = _generateSequence(start),
        maxInSequence = _generateSequence(start).reduce((curr, next) => curr > next ? curr : next),
        sequenceLength = _generateSequence(start).length;

  static List<int> _generateSequence(int x) {
    List<int> seq = [x];
    while (x != 1) {
      if (x % 2 == 0) {
        x = x ~/ 2;
      } else {
        x = 3 * x + 1;
      }
      seq.add(x);
    }
    return seq;
  }
}
