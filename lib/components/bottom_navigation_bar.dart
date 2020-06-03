import 'package:flutter/material.dart';

void bottomNavigationBarTap(uiVariables,currentIndex, context) {
  var oldIndex = uiVariables.bottomNavigationBarIndex;
  uiVariables.setBottomNavigationBarIndex(currentIndex);
  if (currentIndex == 0) {
    uiVariables.controller.loadUrl('https://w3schools.com');
  } else if (currentIndex == 1 && oldIndex != 2) {
    uiVariables.controller.evaluateJavascript('''
    var searchButton = document.querySelector("[title='Search W3Schools']");
    searchButton.click();
    ''');
  } else if (currentIndex == 2) {

  }

}

BottomNavigationBar bottomNavigationBar(uiVariables, context) {
  return BottomNavigationBar(
    unselectedItemColor: Colors.black,
    selectedItemColor: Colors.blue,
    currentIndex: uiVariables.bottomNavigationBarIndex,
    onTap: (index) {
      bottomNavigationBarTap(uiVariables, index, context);
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