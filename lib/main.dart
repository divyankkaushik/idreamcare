import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:idreamcare/feature/authentication/screens/landingscreen/landing_screen.dart';

import 'feature/authentication/screens/widgets/lottie_files.dart';
import 'feature/presentation/screens/homescreen/home_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LottieFiles(),
            );
          } else {
            if (snapshot.hasData) {
              return Homescreen();
            } else {
              return LandingScreen();
            }
          }
        },
      ),
    );
  }
}
