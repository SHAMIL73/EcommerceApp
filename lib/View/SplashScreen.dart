import 'package:flutter/material.dart';
import 'package:flutter_application_2/Const/Color.dart';
import 'dart:async';
import 'package:flutter_application_2/View/auth/Signup.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Loading Time
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Signup()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.trolley,
              color: blackcolor,
              size: 150,
            ),
            const SizedBox(height: 16),
            // Game title
            Text(
              'Eapp',
              style: TextStyle(
                color: blackcolor,
                fontSize: 29.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            // Loading text and animation
            Column(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(blackcolor),
                ),
             
            const SizedBox(height: 16),
            Text(
              'Loading...',
              style: TextStyle(
                color: blackcolor,
                fontSize: 16.0,
              ),
            ),
             ],
            ),
          ],
        ),
      ),
    );
  }
}