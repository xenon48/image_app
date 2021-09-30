import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondarySplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Image.asset('res/images/splash.png'),
        ),
      ),
    );
  }
}