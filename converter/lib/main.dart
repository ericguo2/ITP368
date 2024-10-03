import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Converter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const ConverterHomePage(),
    );
  }
}

class ConverterHomePage extends StatefulWidget {
  const ConverterHomePage({super.key});

  @override
  State<ConverterHomePage> createState() => _ConverterHomePageState();
}

class _ConverterHomePageState extends State<ConverterHomePage> {
  String _input = '';
  String _output = '';
  String _operation = 'F to C';

  void _appendToInput(String value) {
    setState(() {
      _input += value;
    });
  }

  void _clearInput() {
    setState(() {
      _input = '';
      _output = '';
    });
  }

  void _convert() {
    double? inputValue = double.tryParse(_input);
    if (inputValue == null) return;

    double result;
    if (_operation == 'F to C') {
      result = (inputValue - 32) * 5 / 9;
    } else if (_operation == 'C to F') {
      result = (inputValue * 9 / 5) + 32;
    } else if (_operation == 'lb to kg') {
      result = inputValue * 0.453592;
    } else {
      result = inputValue / 0.453592;
    }

    setState(() {
      _output = result.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Temperature and Weight Converter'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<String>(
            value: _operation,
            items: const [
              DropdownMenuItem(value: 'F to C', child: Text('Fahrenheit to Celsius')),
              DropdownMenuItem(value: 'C to F', child: Text('Celsius to Fahrenheit')),
              DropdownMenuItem(value: 'lb to kg', child: Text('Pounds to Kilograms')),
              DropdownMenuItem(value: 'kg to lb', child: Text('Kilograms to Pounds')),
            ],
            onChanged: (String? value) {
              setState(() {
                _operation = value!;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Input: $_input',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Output: $_output',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(8.0),
            width: 200,
            height: 200,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
              ),
              itemCount: 12,
              itemBuilder: (BuildContext context, int index) {
                if (index < 9) {
                  return ElevatedButton(
                    onPressed: () => _appendToInput((index + 1).toString()),
                    child: Text((index + 1).toString()),
                  );
                } else if (index == 9) {
                  return ElevatedButton(
                    onPressed: () => _appendToInput('0'),
                    child: const Text('0'),
                  );
                } else if (index == 10) {
                  return ElevatedButton(
                    onPressed: () => _appendToInput('-'),
                    child: const Text('-'),
                  );
                } else {
                  return ElevatedButton(
                    onPressed: () => _appendToInput('.'),
                    child: const Text('.'),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _convert,
                child: const Text('Convert'),
              ),
              ElevatedButton(
                onPressed: _clearInput,
                child: const Text('Clear'),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
