import 'package:flutter/cupertino.dart';
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
  List allBookmarks;

  Dismissible bookmark(values, index, uiVariables) {
    return Dismissible(
        key: Key(index.toString()),
        direction: DismissDirection.endToStart,
        background: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5),
              child: IconButton(
                onPressed: null,
                icon: Icon(Icons.delete, color: Colors.red, size: 20,),
              ),
            )
          ],
        ),
        onDismissed: (direction) {
          print('Tile Deleted');
          uiVariables.deleteBookmark(index);
          setState(() {
            allBookmarks.removeAt(index);
          });
          print(allBookmarks);
        },
        child: InkWell(
          splashColor: Colors.blue,
          onTap: () {},
          child: Ink(
            child: ListTile(
              leading: Text(index.toString()),
              title: Wrap(
                children: <Widget>[
                  Padding(
                    child: Text(values[1]),
                    padding: EdgeInsets.all(5.0),
                  )
                ],
              ),
              subtitle: Wrap(
                children: <Widget>[
                  Padding(
                    child: Text(values[0]),
                    padding: EdgeInsets.all(5.0),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final uiVariables = Provider.of<UiVariables>(context);
    uiVariables.getBookmarks();
    allBookmarks = uiVariables.allBookmarks;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Bookmarks'),
        ),
        body: ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                height: 1,
                color: Colors.grey[200],
              );
            },
            itemCount: allBookmarks.length,
            itemBuilder: (BuildContext context, int index) {
              print(allBookmarks);
              if (allBookmarks[index] != '') {
                values = allBookmarks[index].split('!@');
                return bookmark(values, index, uiVariables);
              }
              return Container();
            }),
      ),
    );
  }
}
