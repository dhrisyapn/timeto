import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timeto/home.dart';
import 'package:timeto/signin.dart';
import 'package:timeto/transitions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        // Check if the user is logged in
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          // User is logged in, navigate to HomePage
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (Route<dynamic> route) => false,
          );
        } else {
          // User is not logged in, navigate to SignInPage
          Navigator.pushAndRemoveUntil(
              context,
              DissolvePageRoute(page: SigninPage()),
              (Route<dynamic> route) => false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            'assets/name.png',
            height: 40,
          )),
        ],
      ),
    );
  }
}
