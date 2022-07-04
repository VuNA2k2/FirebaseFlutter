import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_tutorial/Models/user.dart';
import 'package:firebase_tutorial/Screens/Authenticate/sign_in.dart';
import 'package:firebase_tutorial/Screens/wrapper.dart';
import 'package:firebase_tutorial/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Wrapper(),
    );
  }
}


