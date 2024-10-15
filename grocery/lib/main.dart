import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery List App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const GroceryListPage(),
    );
  }
}

class GroceryListPage extends StatefulWidget {
  const GroceryListPage({super.key});

  @override
  State<GroceryListPage> createState() => _GroceryListPageState();
}

class _GroceryListPageState extends State<GroceryListPage> {
  List<String> _groceryItems = [];
  final TextEditingController _textController = TextEditingController();
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadGroceryList();
  }

  Future<void> _loadGroceryList() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final String? itemsString = _prefs.getString('groceryItems');
      if (itemsString != null) {
        setState(() {
          _groceryItems = List<String>.from(json.decode(itemsString));
        });
        print('Grocery items loaded: $_groceryItems');
      } else {
        print('No existing grocery list found.');
      }
    } catch (e) {
      print('Error loading grocery list: $e');
    }
  }

  Future<void> _saveGroceryList() async {
    try {
      final String itemsString = json.encode(_groceryItems);
      await _prefs.setString('groceryItems', itemsString);
      print('Grocery list saved successfully');
    } catch (e) {
      print('Error saving grocery list: $e');
    }
  }

  void _addItem() async {
    String newItem = _textController.text.trim();
    if (newItem.isNotEmpty) {
      setState(() {
        _groceryItems.add(newItem);
        _textController.clear();
      });
      await _saveGroceryList();
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      labelText: 'Enter an item',
                    ),
                    onSubmitted: (value) => _addItem(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addItem,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _groceryItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_groceryItems[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
