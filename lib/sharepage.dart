import 'package:tamadun/authentication/log.dart';
import 'package:tamadun/screens/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../fire.dart';
import '../auth/landing_page.dart';
import '../login.dart';

void main() => runApp(MaterialApp(home: hidenav(),
));

class hidenav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SearchPage(),
      ),
    );
  }
}