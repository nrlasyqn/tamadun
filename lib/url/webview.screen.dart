import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../screens/home_page.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  const WebViewScreen({required this.url, Key? key}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text("WEB VIEW",
            style: TextStyle(
              fontFamily: "MontserratBold",
              color: Colors.black,
            ),),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
              });
            },

          ),
        ),
        body: WebView(
          initialUrl: widget.url,
        ),
      ),
    );
  }
}
