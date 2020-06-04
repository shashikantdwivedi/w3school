import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../initalizer.dart';
import 'package:provider/provider.dart';
import 'webview_actions.dart';
import 'package:w3schoolapp/no_internet.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

class WebViewScreen extends StatefulWidget {
  WebViewScreen({this.url});

  String url;

  @override
  State<StatefulWidget> createState() {
    return _WebViewScreen(url: url);
  }
}

class _WebViewScreen extends State<WebViewScreen> {
  _WebViewScreen({this.url});

  String url;

  bool internetStatus = true;
  
  checkInternetConnection() async {
    bool result = await DataConnectionChecker().hasConnection;
    setState(() {
      internetStatus = result;
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    final uiVariables = Provider.of<UiVariables>(context);
    return WebView(
      initialUrl: uiVariables.currentUrl != null ? uiVariables.currentUrl : 'https://www.w3schools.com/',
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController controller) {
        uiVariables.setWebViewController(controller);
      },
      navigationDelegate: (pageUrl) async{
        checkInternetConnection();
        if (!internetStatus) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoInternet()),
          );
        }
        return NavigationDecision.navigate;
      },
      onPageStarted: (pageUrl) {
        uiVariables.controller
            .getTitle()
            .then((value) {
              uiVariables.setTitleAndUrl();

              print(value);
            });
        disableAd(uiVariables.controller);

      },
      onPageFinished: (pageUrl) {
        uiVariables.controller
            .getTitle()
            .then((value) {
          uiVariables.setTitleAndUrl();

          print(value);
        });
        disableAd(uiVariables.controller);
        uiVariables.setPageLoaded(true);
      },
    );
  }
}
