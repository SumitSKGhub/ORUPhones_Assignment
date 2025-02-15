

import 'package:flutter/material.dart';
import 'package:oruphones/core/models/user_model.dart';
import 'package:oruphones/core/services/auth_service.dart';
import 'package:oruphones/locator.dart';
import 'package:stacked/stacked.dart';

class DrawerViewModel extends BaseViewModel{
  final AuthService _authService = locator<AuthService>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoggedIn = false;
  bool isLoading = true;
  UserModel? user;



  void initialize() async {
    isLoggedIn = await _authService.checkAuthStatus();
    notifyListeners();

    if(isLoggedIn){
      user = await _authService.getUser();
      print("User: ");
      print(user?.userName);

      notifyListeners();
    }
    isLoading = false;
    notifyListeners();
  }

  void logout() async{
    await _authService.logout();
    isLoggedIn = false;
    user = null;
    notifyListeners();
  }



}