import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class Database {
  Box bookmarks;
  List allBookmarks;


  Future<void> initializeDb() async{
    final Directory _appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(_appDocDir.path);
    print(_appDocDir.path);
    bookmarks = await Hive.openBox('bookmarks');
  }

  Future<void> saveBookmark(currentUrl, title) async{
//    bookmarks.delete('all');
    String info = await bookmarks.get('all', defaultValue: '');
    dynamic data = info.split('@#');
    print(data);
    info += '@#$currentUrl!@$title';
    print(info);
    bookmarks.put('all', info);
    var items = bookmarks.get('all', defaultValue: '');
    allBookmarks = items.split('@#');
  }

  Future<List> getBookmarks() async{
    var items = await bookmarks.get('all', defaultValue: '');
    allBookmarks = items.split('@#');
    return allBookmarks;
  }

  Future<void> deleteBookmark(index) async{
    var items = bookmarks.get('all', defaultValue: '');
    allBookmarks = items.split('@#');
    allBookmarks.removeAt(index);
    bookmarks.put('all', allBookmarks.join('@#'));
    print('Deleted Bookmark');
  }

}