import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:timeto/addcourse.dart';
import 'package:timeto/course.dart';
import 'package:timeto/firebase_options.dart';
import 'package:timeto/home.dart';
import 'package:timeto/signin.dart';
import 'package:timeto/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Timeto',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF2A7A85),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
