import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_lesson/model/person_model/person_data.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  Box<Person>? box;

  // ignore: unused_element
  void _incrementCounter(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Name'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: name,
              ),
              TextFormField(
                controller: age,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                var res = await http.get(
                  Uri.parse('https://api.genderize.io/?name=${name.text}'),
                );
                Person newPerson = Person.fromJson(jsonDecode(res.body));
                box?.put(name.text, newPerson);
                setState(() {});
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
                name.clear();
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: box?.values.length ?? 0,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  color: Colors.grey,
                  child: Column(
                    children: [
                      Text(
                        'Name: ${box?.values.elementAt(index).name}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      Text(
                        'Name: ${box?.values.elementAt(index).count}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      Text(
                        'ID: ${box?.keys.elementAt(index)}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      IconButton(
                        onPressed: () {
                          box!.deleteAt(index);
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _incrementCounter(context);
          setState(() {});
        },
      ),
    );
  }
}
