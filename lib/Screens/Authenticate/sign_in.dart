
import 'dart:math';

import 'package:firebase_tutorial/Screens/Authenticate/register.dart';
import 'package:firebase_tutorial/Screens/loading.dart';
import 'package:flutter/gestures.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_tutorial/Services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;


  SignIn(this.toggleView);

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase tutorial"),
        actions: [
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Register"),
            onPressed: () {
              widget.toggleView();
            }
          )
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: <Widget> [
                Form(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 4),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            label: Text("Email", style: TextStyle(color: Colors.black),),
                            border: OutlineInputBorder(),
                            hintText: "Enter email",
                            icon: Icon(
                              Icons.email,
                            ),
                          ),
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 4),
                        child: TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            label: Text("Password", style: TextStyle(color: Colors.black),),
                            border: OutlineInputBorder(),
                            hintText: "Enter password",
                            icon: Icon(
                              Icons.password,
                            ),
                          ),
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                        ),
                      )

                    ],
                  ),
                ),
                ElevatedButton(
                  child: Text('Sign In'),
                  onPressed: () async {
                    signIn();
                  },
                ),
                RichText(
                    text: TextSpan(
                        text: "Don't have an account? ",
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                        children: [
                          TextSpan(
                              text: "Register",
                              style: const TextStyle(
                                color: Colors.blue,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                widget.toggleView();
                              }
                          )
                        ]
                    )
                ),
              ],
            ),
            Loading(loading),
          ],
        )
      ),
    );
  }

  void signIn() async {
    setState(() {
      loading = true;
    });
    dynamic result = await _authService.signInEmailPassword(_emailController.text.trim(), _passwordController.text);
    if(result == null) {
      setState(() {
        loading = false;
      });
    }
  }
}





