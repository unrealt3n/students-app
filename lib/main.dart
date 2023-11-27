import 'package:flutter/material.dart';
import 'package:week8/db/db_functions.dart';
import 'package:week8/pages/home/home_page.dart';

void main() async {
  DB db = DB();
  WidgetsFlutterBinding.ensureInitialized();
  await db.openDb();
  runApp(const MyApp());
  await db.getAllStudets();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MyHomePage(),
    );
  }
}
