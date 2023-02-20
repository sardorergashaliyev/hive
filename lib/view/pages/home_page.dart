import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController name = TextEditingController();
  Box? box;

  // ignore: unused_element
  void _incrementCounter(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Name'),
          content: TextFormField(
            controller: name,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                box!.put('name', name.text);
              },
              child: const Text('Save'),
            )
          ],
        );
      },
    );
  }

  hiveInit() async {
    box = await Hive.openBox('myBox');
  }

  @override
  void initState() {
    hiveInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () => _incrementCounter(context),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              box!.get('name'),
            ),
          ],
        ),
      ),
    );
  }
}
