import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/helper/provider_helper.dart';
import 'package:todo_app/screens/list_todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Provider_Helper(),
      child: MaterialApp(
        title: 'Flutter ToDo App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: List_Todo(),
      ),
    );
  }
}
