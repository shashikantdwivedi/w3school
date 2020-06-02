import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class UiVariables extends ChangeNotifier {
  WebViewController controller;
  bool pageLoaded = false;
  int bottomNavigationBarIndex = 0;
  Box bookmarks;
  List allBookmarks;
  var date;
  String currentUrl, title;

  void setPageLoaded(value) {
    pageLoaded = value;
    notifyListeners();
  }

  void initializeApp() async{
    final Directory _appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(_appDocDir.path);
    print(_appDocDir.path);
    bookmarks = await Hive.openBox('bookmarks');
  }

  void saveBookmark() async{
//    bookmarks.delete('all');
    String info = await bookmarks.get('all', defaultValue: '');

    dynamic data = info.split('@#');
    print(data);
    info += '@#$currentUrl!@$title';
    print(info);
    bookmarks.put('all', info);
    var items = bookmarks.get('all', defaultValue: '');
    allBookmarks = items.split('@#');
    notifyListeners();
  }


  void getBookmarks() {
    var items = bookmarks.get('all', defaultValue: '');
    allBookmarks = items.split('@#');
    pageLoaded = true;
    notifyListeners();
  }

  void deleteBookmark(index) async{
    var items = bookmarks.get('all', defaultValue: '');
    allBookmarks = items.split('@#');
    allBookmarks.removeAt(index);
    bookmarks.put('all', allBookmarks.join('@#'));
    print('Deleted Bookmark');
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