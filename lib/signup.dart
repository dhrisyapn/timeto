// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timeto/home.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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

  bool revisible = false;
  var reeyeicon = const Icon(Icons.visibility_off);
  void retoggleicon() {
    setState(() {
      revisible = !revisible;
      if (revisible) {
        reeyeicon = const Icon(Icons.visibility);
      } else {
        reeyeicon = const Icon(Icons.visibility_off);
      }
    });
  }

  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void signUpWithEmailPassword() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
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
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Something went wrong. Please try again.',
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
                height: MediaQuery.of(context).size.height * 0.2,
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
                'Create an account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Full Name',
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
                  controller: nameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    hintText: 'Your name here',
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
                height: 10,
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
                  controller: emailController,
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
                height: 10,
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
                  controller: passwordController,
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
              const Text(
                'Re-type Password',
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
                  controller: rePasswordController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(left: 10, top: 13),
                    hintText: 'Re-type your secret here',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.4000000059604645),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    suffixIcon: IconButton(
                        onPressed: retoggleicon,
                        icon: reeyeicon,
                        color: const Color(0xffffffff)),
                  ),
                  style: const TextStyle(
                    color: Color(0xFFffffff),
                    fontSize: 15,
                  ),
                  obscureText: !revisible,
                  cursorColor: const Color(0xFFffffff),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  //if no field is empty and password matches then sign up
                  if (nameController.text.isNotEmpty &&
                      emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty &&
                      rePasswordController.text.isNotEmpty &&
                      passwordController.text == rePasswordController.text) {
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
                    signUpWithEmailPassword();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Please fill all fields correctly',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400)),
                      ),
                    );
                  }
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
                      'Create Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
