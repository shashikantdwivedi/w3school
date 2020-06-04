import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/bottom_navigation_bar.dart' as bottom_bar;
import 'package:provider/provider.dart';
import 'initalizer.dart';
import 'database.dart' as db;

class Bookmarks extends StatefulWidget {
  db.Database dbInstance;
  UiVariables uiVariables;

  Bookmarks(this.dbInstance, this.uiVariables, {Key key}) : super(key: key);

  @override
  _BookmarksState createState() => _BookmarksState(dbInstance, uiVariables);
}

class _BookmarksState extends State<Bookmarks> {
  _BookmarksState(this.dbInstance, this.uiVariables);

  UiVariables uiVariables;
  List values;
  List allBookmarks;
  db.Database dbInstance;

  @override
  void initState() {
    allBookmarks = dbInstance.allBookmarks;
  }

  Dismissible bookmark(values, index, uiVariables) {
    return Dismissible(
        key: Key(index.toString()),
        direction: DismissDirection.endToStart,
        background: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(child: Container(color: Colors.red[300])),
            Container(
              height: Size.infinite.height,
              color: Colors.red[300],
              padding: EdgeInsets.all(5.0),
              child: IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            )
          ],
        ),
        onDismissed: (direction) {
          print('Tile Deleted');
          dbInstance.deleteBookmark(index);
          setState(() {
            allBookmarks = allBookmarks.removeAt(index);
          });
          print(allBookmarks);
        },
        child: InkWell(
          splashColor: Colors.blue,
          onTap: () {
            uiVariables.setUrl(values[0]);
            uiVariables.setBottomNavigationBarIndex(0);
          },
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
    return ListView.separated(
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
        });
  }
}
