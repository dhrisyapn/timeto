import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
              SizedBox(
                height: 10,
              ),
              Image.asset(
                'assets/name.png',
                height: 28,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Sign up.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Full Name',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: TextField(
                  // controller: emailcontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
              SizedBox(
                height: 10,
              ),
              Text(
                'Email address',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: TextField(
                  // controller: emailcontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
              SizedBox(
                height: 10,
              ),
              Text(
                'Password',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: TextField(
                  // controller: passwordcontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 10, top: 13),
                    hintText: 'Your secret here',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.4000000059604645),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    //   suffixIcon: IconButton(
                    //       onPressed: toggleicon,
                    //       icon: eyeicon,
                    //       color: const Color(0xffffffff)),
                  ),
                  style: const TextStyle(
                    color: Color(0xFFffffff),
                    fontSize: 15,
                  ),
                  // obscureText: visible,
                  cursorColor: const Color(0xFFffffff),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                ' re-type-Password',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: TextField(
                  // controller: passwordcontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 10, top: 13),
                    hintText: 'Your secret here',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.4000000059604645),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    //   suffixIcon: IconButton(
                    //       onPressed: toggleicon,
                    //       icon: eyeicon,
                    //       color: const Color(0xffffffff)),
                  ),
                  style: const TextStyle(
                    color: Color(0xFFffffff),
                    fontSize: 15,
                  ),
                  // obscureText: visible,
                  cursorColor: const Color(0xFFffffff),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  // signInWithEmailPassword();
                },
                child: Container(
                  width: 333,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: Color(0xFF8CC1A9),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Center(
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
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
