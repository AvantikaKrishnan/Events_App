import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/Student.dart';
import 'package:project/UpdateEvent.dart';
import 'package:project/Welcome.dart';
import 'package:project/Welcome_Student.dart';
import 'package:project/displayEverything.dart';
import 'package:project/login.dart';
import 'Teacher.dart';
import 'display_student.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Named Routes Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/teacher': (context) => const Teacher(),
        '/student': (context) => const Student(),
        '/welcome' :(context) => Welcome(),
        '/displayeverything' : (context) => const DisplayEverything(),
        '/update' : (context) => const updateEvent(),
        '/display_student':(context) => const Display_student(),
        '/welcome_student':(context) => Welcome_Student(),


      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[900],
      ),
    );
  }
}
