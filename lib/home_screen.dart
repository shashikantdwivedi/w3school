import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:w3schoolapp/no_internet.dart';
import 'bookmarks.dart';
import 'database.dart' as db;
import 'initalizer.dart';
import 'components/bottom_navigation_bar.dart' as bottom_bar;
import 'screens/home_screens/webview_screen.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

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
  var internetStatus = true;

  checkInternetConnection() async {
    bool result = await DataConnectionChecker().hasConnection;
    setState(() {
      internetStatus = result;
    });
  }

  @override
  void initState() {
    print('State Initialization');
    dbInstance = db.Database();
    dbInstance.initializeDb().whenComplete(() => dbInstance.getBookmarks());
    print(dbInstance.allBookmarks);
    checkInternetConnection();
  }

  Widget getScreen(uiVariables) {
    if (uiVariables.bottomNavigationBarIndex == 0 || uiVariables.bottomNavigationBarIndex == 1) {
      return WebViewScreen();
    } else if (uiVariables.bottomNavigationBarIndex == 2) {
      return Bookmarks(dbInstance, uiVariables);
    }
  }

  Widget getAppBar(index) {
    if (index == 2) {
      return AppBar(
        backgroundColor: Colors.green[400],
        title: Text('Bookmarks'),
      );
    } else if (index == 3) {
      return AppBar(
        backgroundColor: Colors.green[400],
        title: Text('About'),
      );
    }
  }

  FloatingActionButton bookmarkButton(uiVariables) {
    if (dbInstance.allBookmarks != null) {
      isBookmarked = dbInstance.allBookmarks
          .contains('${uiVariables?.currentUrl}!@${uiVariables?.title}') || dbInstance.allBookmarks
          .contains('${uiVariables?.currentUrl}!@${uiVariables?.currentUrl}');
    }
    return FloatingActionButton(
      onPressed: () {
        if (isBookmarked) {
          print('#########@##@@@@@@@@@@@@@@');
          int index;
          if (dbInstance.allBookmarks
              .indexOf('${uiVariables.currentUrl}!@${uiVariables?.title}') !=-1) {
            index = dbInstance.allBookmarks
                .indexOf('${uiVariables.currentUrl}!@${uiVariables?.title}');
          } else {
            index = dbInstance.allBookmarks
                .indexOf('${uiVariables.currentUrl}!@${uiVariables?.currentUrl}');
          }
          dbInstance.deleteBookmark(index);
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
    return internetStatus
        ? FutureBuilder(
            future: dbInstance.getBookmarks(),
            initialData: [],
            // ignore: missing_return
            builder: (context, snapshot) {
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
                      body: getScreen(uiVariables)));
            })
        : NoInternet();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
