import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_balta/models/item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  var items = [];
  HomePage({super.key}) {
    // items.add(Item("Item 1", false));
    // items.add(Item("Item 2", true));
    // items.add(Item("Item 3", false));
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var newItemCtrl = TextEditingController();

  void add() {
    if (newItemCtrl.text.isEmpty) return;
    setState(() {
      widget.items.add(Item(newItemCtrl.text, false));
      newItemCtrl.text = "";
    });
    save();
  }

  void remove(int index) {
    setState(() {
      widget.items.removeAt(index);
      save();
    });
  }

  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null) {
      Iterable decoded = jsonDecode(data);
      List<Item> result = decoded.map((x) => Item.fromJson(x)).toList();
      setState(() {
        widget.items = result;
      });
    }
  }

  Future<void> save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(widget.items));
  }

  _HomePageState() {
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: newItemCtrl,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(labelText: "Novo Item"),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (ctxt, index) {
          final item = widget.items[index];
          return Dismissible(
            key: Key(item.title),
            background: Container(color: Colors.red.withValues(alpha: 0.2)),
            onDismissed: (direction) {
              remove(index);
            },
            child: CheckboxListTile(
              title: Text(item.title),
              value: item.isDone,
              onChanged: (value) {
                setState(() {
                  item.isDone = value;
                  save();
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
      ),
    );
  }
}
