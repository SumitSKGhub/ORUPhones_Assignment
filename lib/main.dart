// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:oruphones/core/services/permission_service.dart';
import 'package:oruphones/locator.dart';
import 'package:oruphones/ui/views/auth/confirm_name_view.dart';
import 'package:oruphones/ui/views/auth/login_view.dart';
import 'package:oruphones/ui/views/auth/verify_otp_view.dart';
import 'package:oruphones/ui/bottomsheets/filter_bottomsheet_view.dart';
import 'package:oruphones/ui/views/home/home_view.dart';
import 'package:oruphones/ui/views/splash/splash_screen.dart';

// final _firebaseMessaging = FirebaseMessaging.instance;
//
// Future<void> initNotifications() async {
//   await _firebaseMessaging.requestPermission();
//   final fCMToken = await _firebaseMessaging.getToken();
//   print("Token: ");
//   print(fCMToken);
//   FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
// }
//
// Future<void> handleBackgroundMessage(RemoteMessage message) async{
//   print("Message: ");
//   print(message);
//   print('Title: ${message.notification?.title}');
//   print('Body: ${message.notification?.body}');
//   print('Payload: ${message.data}');
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // initNotifications();
  // await PermissionService().initNotifications(context);
  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/splash',

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