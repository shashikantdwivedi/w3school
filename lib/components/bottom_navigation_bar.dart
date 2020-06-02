import 'package:flutter/material.dart';
import '../bookmarks.dart';

void bottomNavigationBarTap(uiVariables,currentIndex) {
  if (currentIndex == 0) {
    uiVariables.setBottomNavigationBarIndex(currentIndex);
    uiVariables.controller.loadUrl('https://w3schools.com');
  } else if (currentIndex == 1 && uiVariables.bottomNavigationBarIndex == 0) {
    uiVariables.controller.evaluateJavascript('''
    var searchButton = document.querySelector("[title='Search W3Schools']");
    searchButton.click();
    ''');
  } else if (currentIndex == 2) {
    uiVariables.setBottomNavigationBarIndex(currentIndex);
  }

}

BottomNavigationBar bottomNavigationBar(uiVariables, context) {
  return BottomNavigationBar(
    unselectedItemColor: Colors.black,
    selectedItemColor: Colors.blue,
    currentIndex: uiVariables.bottomNavigationBarIndex,
    onTap: (index) {
      bottomNavigationBarTap(uiVariables, index);
    },
    items: [
      BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home')
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text('Search')
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          title: Text('Bookmarks')
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text('Settings')
      )
    ],
  );
}