
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_tutorial/Services/auth.dart';
import 'package:flutter/material.dart';

import '../loading.dart';


class Register extends StatefulWidget {
  final Function toggleView;


  Register(this.toggleView);

  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        actions: [
          FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("Sign In"),
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
                  child: Text('Register'),
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _authService.registerEmailPassword(_emailController.text.trim(), _passwordController.text);
                    if(result != null) {
                      setState(() {
                        loading = false;
                      });
                    }
                  },
                ),
              ],
            ),
            Loading(loading),
          ],
        )
      ),
    );
  }
}





