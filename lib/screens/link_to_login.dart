import 'package:tamadun/authentication/log.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../fire.dart';
import '../auth/landing_page.dart';
import '../login.dart';
import 'mainbody.dart';

void main() => runApp(MaterialApp(home: checkingpage(),
));

class checkingpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginController(),
          child: LoginScreen(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),
      ),
    );
  }
}