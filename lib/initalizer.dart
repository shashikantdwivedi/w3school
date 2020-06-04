import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UiVariables extends ChangeNotifier {
  WebViewController controller;
  int bottomNavigationBarIndex = 0;
  List allBookmarks;
  String currentUrl, title;
  bool pageLoaded = false;

  void setTitleAndUrl() async{
    title = await controller.getTitle();
    currentUrl = await controller.currentUrl();
    print([title, currentUrl]);
    notifyListeners();
  }

  void setPageLoaded(value) {
    pageLoaded = value;
    notifyListeners();
  }

  void setUrl(url) {
    currentUrl = url;
  }

  void setAllBookmarks(values) {
    allBookmarks = values;
    notifyListeners();
  }

  void setWebViewController(_controller) {
    controller = _controller;
    notifyListeners();
  }

  void setBottomNavigationBarIndex(index) {
    bottomNavigationBarIndex = index;
    notifyListeners();
  }
}