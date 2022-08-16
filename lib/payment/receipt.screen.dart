import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../screens/home_page.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen(this.url, {Key? key}) : super(key: key);

  final String url;

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Receipt detail',
          style: TextStyle(
            fontFamily: 'MontserratBold',
            fontSize: 24,
            color: Colors.black,
          ),),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ),
      body: WebView(
        initialUrl: widget.url,
      ),
    );
  }
}
