import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_lesson/model/person_model/person_data.dart';
import 'package:hive_lesson/view/pages/home_page.dart';

Future<void> main(List<String> args) async {
  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
