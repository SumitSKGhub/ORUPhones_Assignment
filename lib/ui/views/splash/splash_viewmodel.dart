

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';

class SplashViewModel extends BaseViewModel{
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> handleStartup() async {
    await Future.delayed(Duration(seconds: 3));

    // User? user = _auth.currentUser;
    // if(user == null){
    //   _navigateToLogin();
    // }
    // else if(user.displayName == null || user.displayName!.isEmpty){
    //   _navigateToConfirmName();
    // }
    // else{
    //   _navigateToHome();
    // }
  }

  void _navigateToLogin(){

  }

  void _navigateToConfirmName(){

  }

  void _navigateToHome() {

  }
}

