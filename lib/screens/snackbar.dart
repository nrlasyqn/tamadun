import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tamadun/screens/beforetheexistence.dart';

import '../authentication/log.dart';
import '../payment/payment.screen.dart';

//snackbar -> upgrade to premium
void showFloatingFlushbar(
    {@required BuildContext? context,
      @required String? message,
      @required bool? isError}) {
  Flushbar? flush;
  bool? _wasButtonClicked;
  flush = Flushbar<bool>(
    title: "Hi User!", titleColor: Color(hexColor('#ffffff')),
    message: message, messageColor: Color(hexColor('#ffffff')),
    backgroundColor: isError! ? Color(hexColor('#8893bd')): Color(hexColor('#8893bd')),
    duration: Duration(seconds: 5),
    margin: EdgeInsets.all(20),
    icon: Icon(
      Icons.emoji_emotions_outlined,
      color: Color(hexColor('#25346b')),
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
        style: TextStyle(color: Color(hexColor('#25346b')),
          fontFamily: 'PoppinsMedium',),
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
    title: "Want to Explore more?", titleColor: Color(hexColor('#ffffff')),
    message: message, messageColor: Color(hexColor('#ffffff')),
    backgroundColor: isError! ? Color(hexColor('#8893bd')): Color(hexColor('#8893bd')),
    duration: Duration(seconds: 5),
    margin: EdgeInsets.all(20),
    icon: Icon(
      Icons.emoji_emotions_outlined,
      color: Color(hexColor('#25346b')),
    ),
    mainButton: MaterialButton(
      onPressed: () {
        Navigator.push(
            context!, MaterialPageRoute(builder: (context) => PaymentScreen()));
        flush!.dismiss(true); // result = true
      },
      child: Text(
        "Upgrade",
        style: TextStyle(color: Color(hexColor('#25346b')),
          fontFamily: 'PoppinsMedium',),
      ),
    ),
  ) // <bool> is the type of the result passed to dismiss() and collected by show().then((result){})
    ..show(context!).then((result) {});
}