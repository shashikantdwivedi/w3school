import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:w3schoolapp/bookmarks.dart';
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
  getPage(index) {
    if (index == 0) {
      return WebViewScreen();
    } else if (index == 2) {
      return Bookmarks();
    }
  }

  FloatingActionButton bookmarkButton(uiVariables) {
    List allBookmarks = uiVariables.allBookmarks;
    bool isBookmarked = allBookmarks
        .contains('${uiVariables.currentUrl}!@${uiVariables.title}');
    return FloatingActionButton(
      onPressed: () {
        if (isBookmarked) {
          uiVariables.deleteBookmark(allBookmarks
              .indexOf('${uiVariables.currentUrl}!@${uiVariables.title}'));
        } else {
          uiVariables.saveBookmark();
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
    uiVariables.initializeApp();
    uiVariables.getBookmarks();
    var currentIndex = uiVariables.bottomNavigationBarIndex;
    return SafeArea(
      child: Scaffold(
        floatingActionButton:
        currentIndex == 0 ? bookmarkButton(uiVariables) : Container(),
        bottomNavigationBar:
            bottom_bar.bottomNavigationBar(uiVariables, context),
        body: getPage(currentIndex),
      ),
    );
  }
}
