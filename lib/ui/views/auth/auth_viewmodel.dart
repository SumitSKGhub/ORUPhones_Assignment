// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oruphones/core/services/auth_service.dart';
import 'package:oruphones/locator.dart';
import 'package:stacked/stacked.dart';

class AuthViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();

  bool isLoading = false;
  bool tick = false;
  String? phoneNumber;
  String? otp;
  String? updatedUserName;

  void acceptTerms() {
    tick = !tick;
    notifyListeners();
  }

  Future<void> sendOTP(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    bool success = await _authService.sendOTP(phoneNumber!);

    isLoading = false;
    notifyListeners();

    if(success){
      Navigator.pushNamed(context, '/verify-otp',arguments: phoneNumber);
      }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send OTP. Please try again.")),
      );
    }
  }

  Future<bool> verifyOTP(BuildContext context, String phoneNo) async{
    isLoading = true;
    notifyListeners();

    bool success = await _authService.verifyOTP(phoneNo, otp!);

    isLoading = false;
    notifyListeners();

    if(success){
      final user = await _authService.getUserData();

      if(user["isLoggedIn"] == null || user["isLoggedIn"] == false || user["user"]["userName"] == null || user["user"]["userName"].isEmpty ){
        print("User Name: "+user["isLoggedIn"].toString());
        Navigator.pushNamed(context, '/confirm-name');
      }else{
        Navigator.pushNamed(context, '/home');
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid OTP! Try Again."))
      );
    }

    return success;
  }

  Future<bool> updateUserName(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    bool success = await _authService.updateUserName(updatedUserName!);

    if(success){
      Navigator.pushNamed(context, '/home');
    }

    isLoading = false;
    notifyListeners();

    return success;
  }
}