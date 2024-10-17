import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  bool visible = true;
  var eyeicon = const Icon(Icons.visibility);
  void toggleicon() {
    setState(() {
      visible = !visible;
      if (!visible) {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              'Sign in to your account.',
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
              width: 333,
              height: 50,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: TextField(
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
              height: 20,
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
              width: 333,
              height: 50,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: TextField(
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
                  suffixIcon: IconButton(
                      onPressed: toggleicon,
                      icon: eyeicon,
                      color: const Color(0xffffffff)),
                ),
                style: const TextStyle(
                  color: Color(0xFFffffff),
                  fontSize: 15,
                ),
                obscureText: visible,
                cursorColor: const Color(0xFFffffff),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
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
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
