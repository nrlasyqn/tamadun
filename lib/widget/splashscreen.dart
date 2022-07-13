import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tamadun/explore_button.dart';
import 'package:tamadun/widget/constant.dart';

import '../screens/link_to_login.dart';
import '../login.dart';

class SplashScreenTest extends StatefulWidget {

  @override
  State<SplashScreenTest> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
          children: <Widget>[
            Expanded(child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/splashscreen.gif"),
                  )
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 50.0, 30, 0),
                    //todo: insert text
                    child: Text(
                      'Tamadun.',
                      style: TextStyle(
                        fontSize: 64,
                        color: Colors.white,
                        fontFamily: 'MontserratExtraBold',
                      ),
                    ),
                  ),

                  Container(
                    child: Text(
                      "lingua revolution & human civilization",
                      style: TextStyle(
                        fontSize: 16,
                        color:Colors.white,
                        fontFamily: 'PoppinsMedium',
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      child: Bottom(),
                    ),
                  )
                ],
              ),
            ),
            ),
          ]
      ),
    );
  }
}

class Bottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: RaisedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>checkingpage()));
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32))
        ),
        child: Text(
          'Explore',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(hexColor('24346C')),
              fontSize: 20,
              fontFamily: 'MontserratBold'
          ),
        ),
        color: mPrimaryColor,
        elevation: 5,
      ),
    );
  }
}

int hexColor(String color) {
  //adding prefix
  String newColor = '0xff' + color;
  //removing # sign
  newColor = newColor.replaceAll('#', '');
  //converting it to the integer
  int finalColor = int.parse(newColor);
  return finalColor;
}