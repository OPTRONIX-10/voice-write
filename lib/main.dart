import 'package:flutter/material.dart';
import 'package:new_project/screens/login_page.dart';
import 'package:new_project/screens/spash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.teal,
      ),
      home: LoadingPage(),
    );
  }
}

