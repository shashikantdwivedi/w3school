import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'initalizer.dart';
import 'components/bottom_navigation_bar.dart' as bottom_bar;
import 'screens/home_screens/webview_screen.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    final uiVariables = Provider.of<UiVariables>(context);
      uiVariables.initializeApp();
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            uiVariables.saveBookmark();
          },
          child: Icon(
            Icons.bookmark_border,
            color: Colors.white,
          ),
          backgroundColor: Colors.green,
        ),
        bottomNavigationBar: bottom_bar.bottomNavigationBar(uiVariables, context),
        body: WebViewScreen(),
      ),
    );
  }
}
