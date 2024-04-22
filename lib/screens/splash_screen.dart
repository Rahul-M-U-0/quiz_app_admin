import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_admin/screens/login_screen.dart';
import 'package:quiz_admin/screens/main_screen.dart';

class QuizSplashScreen extends StatefulWidget {
  const QuizSplashScreen({super.key});

  @override
  State<QuizSplashScreen> createState() => _QuizSplashScreenState();
}

class _QuizSplashScreenState extends State<QuizSplashScreen>
    with TickerProviderStateMixin {
  void gotoOnboardScreen() {
    Timer(
      const Duration(
        milliseconds: 4535,
      ),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => checkUserLoggedinOrNot(),
          ),
        );
      },
    );
  }

  Widget checkUserLoggedinOrNot() {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, AsyncSnapshot<User?> user) {
        if (user.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.only(
              bottom: 5.0,
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CircularProgressIndicator(
                color: Colors.yellow,
              ),
            ),
          );
        } else if (user.hasData) {
          return const MainScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }

  @override
  void initState() {
    gotoOnboardScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.2),
      body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Lottie.asset(
                "assets/animations/welcome_image.json",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
