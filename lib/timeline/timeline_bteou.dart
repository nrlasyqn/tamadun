import 'package:tamadun/timeline/timeline_widget.dart';
import 'package:flutter/material.dart';

import 'bteou_widget.dart';

class TimelineBteou extends StatefulWidget {
  const TimelineBteou({Key? key}) : super(key: key);

  @override
  State<TimelineBteou> createState() => _TimelineBteouState();
}

class _TimelineBteouState extends State<TimelineBteou> {
  var color = [Colors.lightGreenAccent, Colors.blueAccent, Colors.redAccent, Colors.redAccent];

  var url = [
    "https://media.giphy.com/media/ULg6PX4wff5xDcf6SP/giphy.gif",
    "https://media.giphy.com/media/JXHhI4o9NCf8k/giphy.gif",
    "https://media.giphy.com/media/bac4so3wqK6b86Et9C/giphy.gif",
    "https://media.giphy.com/media/0YqhxQdc0tsZh4eE0l/giphy.gif"
  ];

  var text = ['before c. 2,600,000', 'c. 2,600,000', 'c. 40,000', 'c. 2,000,000'];

  var title = ['The Creation of Qalam', 'The Creation of Water', 'The Creation of Arash', 'Zulumat Wa Nur (Explosion  - Light and Darkness Event)'];

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
            child: BteouWidget(url: url, color: color, text: text, title: title,),
          )),
    );
  }
}