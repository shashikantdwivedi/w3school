import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../initalizer.dart';
import 'package:provider/provider.dart';
import 'webview_actions.dart';

class WebViewScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _WebViewScreen();
  }

}

class _WebViewScreen extends State<WebViewScreen> {

  @override
  Widget build(BuildContext context) {
    final uiVariables = Provider.of<UiVariables>(context);
    return WebView(
      initialUrl: 'https://www.w3schools.com/',
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController controller) {
        uiVariables.setWebViewController(controller);
      },
      onPageStarted: (pageUrl) {
        print('On Page Start');
        print(uiVariables.controller.currentUrl());
        disableAd(uiVariables.controller);
      },
      onPageFinished: (pageUrl) {
        uiVariables.controller.getTitle().then((value) => {
          uiVariables.title = value
        });
        uiVariables.currentUrl = pageUrl;
        print('On Page Finished');
        print(uiVariables.controller.currentUrl());
        disableAd(uiVariables.controller);
      },
    );
  }

}
