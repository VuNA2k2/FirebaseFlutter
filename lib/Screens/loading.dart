import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Loading extends StatefulWidget {
  bool loading;
  Loading(this.loading);
  @override
  State<StatefulWidget> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Visibility(
        visible: widget.loading,
        child: Container(
          child: SpinKitCircle(
            color: Colors.white70,
            size: 50,
          ),
          color: Color.fromRGBO(0, 0, 0, 80),
        )
      )
    );
  }
}
