import 'package:flutter/material.dart';
import 'components/bottom_navigation_bar.dart' as bottom_bar;
import 'package:provider/provider.dart';
import 'initalizer.dart';

class Bookmarks extends StatefulWidget {
  Bookmarks({Key key}) : super(key: key);

  @override
  _BookmarksState createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  List values;
  @override
  Widget build(BuildContext context) {
    final uiVariables = Provider.of<UiVariables>(context);
    uiVariables.getBookmarks();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bookmarks'),
        ),
        bottomNavigationBar: bottom_bar.bottomNavigationBar(uiVariables, context),
        body: ListView.builder(
             itemCount: uiVariables.allBookmarks.length,
            itemBuilder: (BuildContext context, int index) {
               if (uiVariables.allBookmarks[index] != '') {
                 values = uiVariables.allBookmarks[index].split(' ');
               }
               return ListTile(
                 title: values[1]
               );
        }),
      ),
    );
  }
}