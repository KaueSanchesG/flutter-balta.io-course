import 'package:flutter/material.dart';
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
    items.add(Item("Item 1", false));
    items.add(Item("Item 2", true));
    items.add(Item("Item 3", false));
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var newItemCtrl = TextEditingController();
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
          return CheckboxListTile(
            title: Text(item.title),
            key: Key(item.title),
            value: item.isDone,
            onChanged: (value) {
              setState(() {
                item.isDone = value;
              });
            },
          );
        },
      ),
    );
  }
}
