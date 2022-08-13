import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tamadun/widget/constant.dart';

import '../authentication/log.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: screenWidth < 576
      ? Column(children: <Widget>[
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/splashscreen3.gif"),
            )),
            child: Column(
              children: <Widget>[
                // Container(
                //   padding: const EdgeInsets.fromLTRB(0, 50.0, 30, 0),
                //   //todo: insert text
                //   child: const Text(
                //     'Tamadun.',
                //     style: TextStyle(
                //       fontSize: 64,
                //       color: Colors.white,
                //       fontFamily: 'MontserratExtraBold',
                //     ),
                //   ),
                // ),
                // const Text(
                //   "lingua revolution & human civilization",
                //   style: TextStyle(
                //     fontSize: 16,
                //     color: Colors.white,
                //     fontFamily: 'PoppinsMedium',
                //   ),
                // ),
                Expanded(
                  child: Bottom(),
                )
              ],
            ),
          ),
        ),
      ])
      //todo: tab
          : screenWidth < 992
      ? Column(children: <Widget>[
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/splashscreen3.gif"),
                )),
            child: Column(
              children: <Widget>[
                // Container(
                //   padding: const EdgeInsets.fromLTRB(0, 50.0, 30, 0),
                //   //todo: insert text
                //   child: const Text(
                //     'Tamadun.',
                //     style: TextStyle(
                //       fontSize: 64,
                //       color: Colors.white,
                //       fontFamily: 'MontserratExtraBold',
                //     ),
                //   ),
                // ),
                // const Text(
                //   "lingua revolution & human civilization",
                //   style: TextStyle(
                //     fontSize: 16,
                //     color: Colors.white,
                //     fontFamily: 'PoppinsMedium',
                //   ),
                // ),
                Expanded(
                  child: BottomTab(),
                )
              ],
            ),
          ),
        ),
      ])
          : null
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
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ));
        },
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32))),
        color: mPrimaryColor,
        elevation: 5,
        child: Text(
          'Explore',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(hexColor('24346C')),
              fontSize: 20,
              fontFamily: 'MontserratBold'),
        ),
      ),
    );
  }
}

class BottomTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
        child: MaterialButton(
          height: 60.0,
          minWidth: 160.0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32))),
          color: mPrimaryColor,
          elevation: 5,
          child: Text(
            'Explore',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(hexColor('24346C')),
                fontSize: 22,
                fontFamily: 'MontserratBold'),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ));
          },
        )
      // child: RaisedButton(
      //   padding: EdgeInsets.fromLTRB(20, 7, 20, 70),
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => const LoginScreen(),
      //         ));
      //   },
      //   shape: const RoundedRectangleBorder(
      //       borderRadius: BorderRadius.all(Radius.circular(32))),
      //   color: mPrimaryColor,
      //   elevation: 5,
      //   child: Text(
      //     'Explore',
      //     textAlign: TextAlign.center,
      //     style: TextStyle(
      //         color: Color(hexColor('24346C')),
      //         fontSize: 20,
      //         fontFamily: 'MontserratBold'),
      //   ),
      // ),
    );
  }
}

int hexColor(String color) {
  //adding prefix
  String newColor = '0xff$color';
  //removing # sign
  newColor = newColor.replaceAll('#', '');
  //converting it to the integer
  int finalColor = int.parse(newColor);
  return finalColor;
}
