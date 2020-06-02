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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      initialRoute: '/',
      routes: {
        '/': (context) => ChangeNotifierProvider(create: (_) => UiVariables(), child: HomePage()),
        '/bookmarks': (context) => ChangeNotifierProvider(create: (_) => UiVariables(), child: Bookmarks()),
      },
    );
  }
}