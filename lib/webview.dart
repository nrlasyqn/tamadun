import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewLoad extends StatefulWidget {

  WebViewLoadUI createState() => WebViewLoadUI();

}

class WebViewLoadUI extends State<WebViewLoad>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          centerTitle: true,
          title: Text('About Us',
            style: TextStyle (
              fontFamily: 'MontserratBold',
              fontSize: 24,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: WebView(
          initialUrl: 'https://aqwise.my/about-us/',
          javascriptMode: JavascriptMode.unrestricted,

        )
    );
  }
}