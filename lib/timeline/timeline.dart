import 'package:tamadun/timeline/timeline_widget.dart';
import 'package:flutter/material.dart';

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  var color = [Colors.lightGreenAccent, Colors.blueAccent, Colors.redAccent];

  var url = [
    "https://qph.cf2.quoracdn.net/main-qimg-005e40dfa083a45068cb6c11a18805c8-lq",
    "https://upload.wikimedia.org/wikipedia/commons/2/2c/Rotating_earth_%28large%29.gif",
    "https://media.giphy.com/media/bac4so3wqK6b86Et9C/giphy.gif"
  ];

  var text = ['before c. 2,600,000', 'c. 2,600,000', 'c. 40,000'];

  var title = ['Big Bang', 'Ancient Flora & Fauna', 'Homo Erectus & Their Species'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            title: Text(
              'The Existence of Universe',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: IconButton(
              onPressed:(){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios,size: 25,color: Colors.black,),
            ),
          ),
          body: Center(
            child: TimelineWidget(url: url, color: color, text: text, title: title,),
          )),
    );
  }
}