// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oruphones/core/services/auth_service.dart';
import 'package:oruphones/locator.dart';
import 'package:oruphones/ui/views/auth/login_view.dart';
import 'package:oruphones/ui/views/auth/verify_otp_view.dart';
import 'package:stacked/stacked.dart';

class AuthViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();

  bool isLoading = false;
  bool tick = false;
  String? phoneNumber;
  String? otp;
  String? updatedUserName;
  BuildContext? contextHome;

  void acceptTerms() {
    tick = !tick;
    notifyListeners();
  }

  Future<void> sendOTP(BuildContext context, bool isBottomSheet) async {
    isLoading = true;
    notifyListeners();
    Future.delayed(Duration(seconds: 1));

    bool success = await _authService.sendOTP(phoneNumber!);

    isLoading = false;
    notifyListeners();

    if (success) {
      if (isBottomSheet) {
        print(phoneNumber!);
        launchOTPVerifyBottomSheet(contextHome!, phoneNumber!);
      } else {
        Navigator.pushNamed(context, '/verify-otp', arguments: phoneNumber);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send OTP. Please try again.")),
      );
    }
  }

  void launchOTPVerifyBottomSheet(BuildContext context, String phoneNumber) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) => DraggableScrollableSheet(
            initialChildSize: 0.5, // 50% of screen height initially
            minChildSize: 0.4, // Minimum height
            maxChildSize: 0.9, // Expand up to 90% of screen
            expand: false,
            builder: (context, scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16.0),
                  child: VerifyOtpView(
                    isBottomSheet: true,
                    phone: phoneNumber,
                  ),
                ),
              );
            }));
  }

  Future<bool> verifyOTP(BuildContext context, String phoneNo) async {
    isLoading = true;
    notifyListeners();

    bool success = await _authService.verifyOTP(phoneNo, otp!);

    isLoading = false;
    notifyListeners();

    if (success) {
      final user = await _authService.getUserData();

      if (user["isLoggedIn"] == null ||
          user["isLoggedIn"] == false ||
          user["user"]["userName"] == null ||
          user["user"]["userName"].isEmpty) {
        print("User Name: " + user["isLoggedIn"].toString());
        Navigator.pushNamed(context, '/confirm-name');
      } else {
        Navigator.pushNamed(context, '/home');
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid OTP! Try Again.")));
    }

    return success;
  }

  Future<bool> updateUserName(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    bool success = await _authService.updateUserName(updatedUserName!);

    if (success) {
      Navigator.pushNamed(context, '/home');
    }

    isLoading = false;
    notifyListeners();

    return success;
  }
}
