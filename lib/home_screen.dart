import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bookmarks.dart';
import 'database.dart' as db;
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
  final homeScreenKey = GlobalKey<ScaffoldState>();
  db.Database dbInstance;
  bool isBookmarked = false;

  @override
  void initState() {
    print('State Initialization');
    dbInstance = db.Database();
    dbInstance.initializeDb().whenComplete(() => dbInstance.getBookmarks());
    print(dbInstance.allBookmarks);
  }

  Widget getScreen(index) {
    if (index == 0 || index == 1) {
      return WebViewScreen();
    } else if (index == 2) {
      return Bookmarks(dbInstance);
    }
  }

  Widget getAppBar(index) {
    if (index == 2) {
      return AppBar(
        backgroundColor: Colors.green[400],
        title: Text('Bookmarks'),
      );
    }
  }

  FloatingActionButton bookmarkButton(uiVariables) {
    if (dbInstance.allBookmarks != null) {
      isBookmarked = dbInstance.allBookmarks
          .contains('${uiVariables?.currentUrl}!@${uiVariables?.title}');
    }
    return FloatingActionButton(
      onPressed: () {
        if (isBookmarked) {
          dbInstance.deleteBookmark(dbInstance.allBookmarks
              .indexOf('${uiVariables.currentUrl}!@${uiVariables?.title}'));
          setState(() {
            isBookmarked = false;
          });
          homeScreenKey.currentState.showSnackBar(SnackBar(
            content: Text('Bookmark Deleted'),
            backgroundColor: Colors.red[400],
            duration: Duration(seconds: 1),
          ));
        } else {
          print('${uiVariables?.currentUrl}, ${uiVariables?.title}');
          dbInstance.saveBookmark(uiVariables?.currentUrl, uiVariables?.title);
          setState(() {
            isBookmarked = true;
          });
          homeScreenKey.currentState.showSnackBar(SnackBar(
            content: Text('Bookmark Added'),
            backgroundColor: Colors.green[400],
            duration: Duration(seconds: 1),
          ));
        }
      },
      child: isBookmarked
          ? Icon(
              Icons.delete,
              color: Colors.white,
            )
          : Icon(
              Icons.bookmark_border,
              color: Colors.white,
            ),
      backgroundColor: Colors.green,
    );
  }

  @override
  Widget build(BuildContext context) {
    final uiVariables = Provider.of<UiVariables>(context);
    return FutureBuilder(
        future: dbInstance.getBookmarks(),
        initialData: [],
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != []) {
              print(snapshot.data);
              return SafeArea(
                  child: Scaffold(
                      key: homeScreenKey,
                      appBar: getAppBar(uiVariables.bottomNavigationBarIndex),
                      floatingActionButton:
                          uiVariables.bottomNavigationBarIndex != 2
                              ? bookmarkButton(uiVariables)
                              : Container(),
                      bottomNavigationBar:
                          bottom_bar.bottomNavigationBar(uiVariables, context),
                      body: getScreen(uiVariables.bottomNavigationBarIndex)));
            }
          } else {
            return SafeArea(
                child: Scaffold(
                    body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black87,
                strokeWidth: 1,
              ),
            )));
          }
        });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
