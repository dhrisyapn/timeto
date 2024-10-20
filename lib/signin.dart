// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timeto/home.dart';
import 'package:timeto/signup.dart';
import 'package:timeto/transitions.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //sign in function
  Future<void> signInWithEmailPassword() async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text.trim(),
      );
      Navigator.pop(context);
      // Check if sign in was successful
      if (userCredential.user != null) {
        // Navigate to your target page if login is successful
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Wrong email or password provided.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400)),
        ),
      );
    }
  }

  bool visible = false;
  var eyeicon = const Icon(Icons.visibility_off);
  void toggleicon() {
    setState(() {
      visible = !visible;
      if (visible) {
        eyeicon = const Icon(Icons.visibility);
      } else {
        eyeicon = const Icon(Icons.visibility_off);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.25, // 50% of screen height
              ),
              Image.asset(
                'assets/profile-icon.gif',
                height: 80,
              ),
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                'assets/name.png',
                height: 28,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Sign in to your account.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Email address',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: TextField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    hintText: 'Your email here',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.4000000059604645),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  style: const TextStyle(
                    color: Color(0xFFffffff),
                    fontSize: 15,
                  ),
                  cursorColor: const Color(0xFFffffff),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Password',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: TextField(
                  controller: passwordcontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(left: 10, top: 13),
                    hintText: 'Your secret here',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.4000000059604645),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    suffixIcon: IconButton(
                        onPressed: toggleicon,
                        icon: eyeicon,
                        color: const Color(0xffffffff)),
                  ),
                  style: const TextStyle(
                    color: Color(0xFFffffff),
                    fontSize: 15,
                  ),
                  obscureText: !visible,
                  cursorColor: const Color(0xFFffffff),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  //non dismissible dialogue box with loading indicator
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const Dialog(
                        backgroundColor: Colors.transparent,
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  );

                  signInWithEmailPassword();
                },
                child: Container(
                  width: 333,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF8CC1A9),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    EnterRoute(page: const SignUpPage()),
                  );
                },
                child: Container(
                  width: 333,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Create account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
