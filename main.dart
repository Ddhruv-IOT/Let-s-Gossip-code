import 'package:whatschat/maps.dart';
import 'splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home.dart';
import 'register.dart';
import 'login.dart';
import 'chat.dart';
import 'location.dart';
//import 'myimage_camera.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'Georgia',
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      initialRoute: "splash",
      routes: {
        "splash": (context) => MyApp(),
        "home": (context) => Myhome(),
        "reg": (context) => MyReg(),
        "login": (context) => MyLogin(),
        "chat": (context) => Mychat(),
        "location": (context) => Gmaps(),
        "maps": (context) => Maps(),
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}
