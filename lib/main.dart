import 'package:flutter/material.dart';
import 'package:phantomsolutions2/firebase_options.dart';
import 'package:phantomsolutions2/font_theme.dart';
import 'package:phantomsolutions2/tasks/task_list.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: myfonts,
        primarySwatch: Colors.blue,
      ),
      home: const TaskList(),
    );
  }
}
