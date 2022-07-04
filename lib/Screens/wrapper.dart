import 'package:firebase_tutorial/Models/user.dart';
import 'package:firebase_tutorial/Screens/Authenticate/authenticate.dart';
import 'package:firebase_tutorial/Screens/Authenticate/sign_in.dart';
import 'package:firebase_tutorial/Screens/Home/home.dart';
import 'package:firebase_tutorial/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class Wrapper extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {


  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _authService.user,
      builder: (context, snapshot) {
        if(snapshot.hasData) return Home();
        else return Authenticate();
      },
    );
  }
}


