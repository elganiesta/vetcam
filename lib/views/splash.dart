import 'dart:async';

import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({ Key? key }) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    initializeApp(context).whenComplete(() => startApp());
    super.initState();
  }

  Future initializeApp(context) async {
    
  }

  startApp() async {
    return Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/Workshops');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/vetcam.png",
          width: 500,
          height: 500,
        ),
      ),
    );
  }
}