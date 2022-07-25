import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tamadun/screens/beforetheexistence.dart';

import '../payment/payment.screen.dart';

//snackbar -> upgrade to premium
void showFloatingFlushbar(
    {@required BuildContext? context,
      @required String? message,
      @required bool? isError}) {
  Flushbar? flush;
  bool? _wasButtonClicked;
  flush = Flushbar<bool>(
    title: "Hey",
    message: message,
    backgroundColor: isError! ? Colors.red : Colors.deepPurple,
    duration: Duration(seconds: 5),
    margin: EdgeInsets.all(20),
    icon: Icon(
      Icons.emoji_emotions_outlined,
      color: Colors.white,
    ),
    mainButton: MaterialButton(
      onPressed: () {
        //todo: add payment screen
        Navigator.push(
            context!, MaterialPageRoute(builder: (context) => PaymentScreen()));
        flush!.dismiss(true); // result = true
      },
      child: Text(
        "Upgrade",
        style: TextStyle(color: Colors.yellow),
      ),
    ),
  ) // <bool> is the type of the result passed to dismiss() and collected by show().then((result){})
    ..show(context!).then((result) {});
}

//ask user to buy
void showAskUserBar(
    {@required BuildContext? context,
      @required String? message,
      @required bool? isError}) {
  Flushbar? flush;
  bool? _wasButtonClicked;
  flush = Flushbar<bool>(
    title: "Want to Explore more?",
    message: message,
    backgroundColor: isError! ? Colors.red : Colors.deepPurple,
    duration: Duration(seconds: 5),
    margin: EdgeInsets.all(20),
    icon: Icon(
      Icons.emoji_emotions_outlined,
      color: Colors.white,
    ),
    mainButton: MaterialButton(
      onPressed: () {
        Navigator.push(
            context!, MaterialPageRoute(builder: (context) => PaymentScreen()));
        flush!.dismiss(true); // result = true
      },
      child: Text(
        "Upgrade",
        style: TextStyle(color: Colors.yellow),
      ),
    ),
  ) // <bool> is the type of the result passed to dismiss() and collected by show().then((result){})
    ..show(context!).then((result) {});
}