import 'package:webview_flutter/webview_flutter.dart';

void disableAd(WebViewController controller) {
  controller.evaluateJavascript('''
  var mainLeaderboard = document.getElementById('mainLeaderboard');
  var midcontentadcontainer = document.getElementById('midcontentadcontainer');
  var skyscraper = document.getElementById('skyscraper');
  var bottomad = document.getElementsByClassName('bottomad')[0];
  var tryitLeaderboard = document.getElementById('tryitLeaderboard');
  var trytopnav = document.getElementsByClassName('trytopnav')[0];
  if (mainLeaderboard != undefined ) {
    mainLeaderboard.remove();
  } 
  if (midcontentadcontainer != undefined ) {
    midcontentadcontainer.remove();
  }
  if (skyscraper != undefined ) {
    skyscraper.remove();
  }
  if (bottomad != undefined ) {
    bottomad.remove();
  }
  if (tryitLeaderboard != undefined) {
    tryitLeaderboard.remove();
    trytopnav.style.top = '0px';
  }
  ''');
}