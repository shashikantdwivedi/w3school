import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'initalizer.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(create: (_) => UiVariables(), child: HomePage()),
    );
  }
}