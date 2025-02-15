

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:oruphones/core/services/auth_service.dart';
import 'package:oruphones/core/services/permission_service.dart';
import 'package:oruphones/locator.dart';
import 'package:stacked/stacked.dart';

class SplashViewModel extends BaseViewModel{
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService _authService = locator<AuthService>();
  final PermissionService _permissionService = locator<PermissionService>();

  // final PermissionService
  // final NavigationService

  Future<void> handleStartup(BuildContext context) async {
    setBusy(true);
    // await Future.delayed(Duration(seconds: 3));
    _permissionService.initNotifications();
    bool isLoggedIn = await _authService.checkAuthStatus();

    if(isLoggedIn){
      var user = await _authService.getUserData();
      if(user["user"]["userName"]== null){
        Navigator.pushNamed(context, '/confirm-name');
      }else if(user == {}){
        Navigator.pushNamed(context, '/login');
      }
      else{
        Navigator.pushNamed(context, '/home');
      }
      // if(user.name.isEmpty){
      //
      // }
    }

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

    setBusy(false);
  }

  void _navigateToLogin(){

  }

  void _navigateToConfirmName(){

  }

  void _navigateToHome() {

  }
}

