import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:oruphones/ui/views/splash/splash_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Future.delayed(
      Duration(seconds: 5),
      () => Navigator.pushNamed(context, '/login'),
    );

    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => SplashViewModel(),
      onViewModelReady: (model) => model.handleStartup(),
      builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Lottie.asset(
              'assets/animations/Splash.json',
              repeat: false,
              fit: BoxFit.cover,
            ),
          )),
    );
  }
}
