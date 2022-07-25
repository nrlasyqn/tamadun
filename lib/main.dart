import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tamadun/widget/constant.dart';
import 'auth/landing_page.dart';
import 'auth/user.provider.dart';
import 'login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const TamadunApp());
}

class TamadunApp extends StatefulWidget {
  const TamadunApp({Key? key}) : super(key: key);

  @override
  State<TamadunApp> createState() => _TamadunAppState();
}

class _TamadunAppState extends State<TamadunApp> {
  final appUser = AppUser();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppUser>.value(value: appUser),
        ChangeNotifierProvider(create: (context) => LoginController()),
        ChangeNotifierProvider<AppUser>(
          create: (context) => AppUser(),
        )
      ],
      child: MaterialApp(
        title: 'Tamadun App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Montserrat',
          scaffoldBackgroundColor: mBackgroundColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const LandingPage(),
      ),
    );
  }
}
