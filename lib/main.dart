import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week8/db/db_functions.dart';
import 'package:week8/pages/home/home_page.dart';
import 'package:week8/providers/students.dart';

void main() async {
  DB db = DB();
  WidgetsFlutterBinding.ensureInitialized();
  await db.openDb();
  runApp(ChangeNotifierProvider(
      create: (context) => StudentsProvider(), child: const MyApp()));
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
      home: MyHomePage(),
    );
  }
}
