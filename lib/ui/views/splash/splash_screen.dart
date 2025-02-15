import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:oruphones/ui/views/splash/splash_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => SplashViewModel(),
      onViewModelReady: (model) => model.handleStartup(context),
      builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
          body: Center(
              child:
              // model.isBusy
              //     ?
              Lottie.asset(
                      'assets/animations/Splash.json',
                      repeat: true,
                      fit: BoxFit.cover,
                    )
                  // : Center(
                  //     child: CircularProgressIndicator(),
                  //   )
                  ,
          )
      )
      ,
    );
  }
}
