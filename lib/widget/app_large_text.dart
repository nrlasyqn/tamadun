import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLargeText extends StatelessWidget {
  double size;
  final String text;
  final Color color;


  AppLargeText({Key? key,
    this.size=64,
    required this.text,
    this.color=Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        style: TextStyle(
            fontFamily:'MontserratExtraBold',
            color:color,
            fontSize:size,

        )

    );
  }
}