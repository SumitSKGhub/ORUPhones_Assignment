// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oruphones/locator.dart';
import 'package:oruphones/ui/views/auth/confirm_name_view.dart';
import 'package:oruphones/ui/views/auth/login_view.dart';
import 'package:oruphones/ui/views/auth/verify_otp_view.dart';
import 'package:oruphones/ui/views/home/home_view.dart';
import 'package:oruphones/ui/views/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/home',

      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginView(),
        '/verify-otp': (context) => VerifyOtpView(),
        '/confirm-name': (context) => ConfirmNameView(),
        '/home': (context) => HomeView(),
      },
    );
  }
}