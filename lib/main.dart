import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'initalizer.dart';
import 'package:provider/provider.dart';
import 'bookmarks.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => UiVariables(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => HomePage(),
          },
        ));
  }
}
