import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oruphones/ui/views/auth/auth_viewmodel.dart';
import 'package:stacked/stacked.dart';

class VerifyOtpView extends StatelessWidget {
  final TextEditingController otpController1 = TextEditingController();
  final TextEditingController otpController2 = TextEditingController();
  final TextEditingController otpController3 = TextEditingController();
  final TextEditingController otpController4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String phoneNumber =
        ModalRoute.of(context)!.settings.arguments as String;

    return ViewModelBuilder<AuthViewModel>.reactive(
      viewModelBuilder: () => AuthViewModel(),
      builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            // leading: Icon(Icons.arrow_back),
            backgroundColor: Colors.white,
          ),
          body:
              // Padding(
              //   padding: EdgeInsets.all(16.0),
              //   child: Column(
              //     children: [
              //       TextField(
              //         controller: otpController,
              //         keyboardType: TextInputType.number,
              //         decoration: InputDecoration(
              //           labelText: "Enter OTP",
              //           border: OutlineInputBorder(),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 20,
              //       ),
              //       model.isLoading
              //           ? CircularProgressIndicator()
              //           : ElevatedButton(
              //               onPressed: () async {
              //                 model.otp = otpController.text;
              //                 bool success =
              //                     await model.verifyOTP(context, phoneNumber);
              //
              //                 // if (success) {
              //                 //   Navigator.pushNamed(context, '/home');
              //                 // } else {
              //                 //   ScaffoldMessenger.of(context).showSnackBar(
              //                 //     SnackBar(content: Text("Invalid OTP! Try Again.")),
              //                 //   );
              //                 // }
              //               },
              //               child: Text("Verify OTP")
              //       ),
              //     ],
              //   ),
              // ),

              Container(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/logo/logo_login.png",
                    fit: BoxFit.cover,
                    height: 80,
                    width: 150,
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Text(
                    "Verify Mobile No.",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: Color(0xFF3F3E8F)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    "Please enter the 4 digit verification code sent to you mobile number +91-$phoneNumber via SMS",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 120,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        _OTPField(otpController1, context),
                            SizedBox(width: 12),
                        _OTPField(otpController2, context),
                            SizedBox(width: 12),
                        _OTPField(otpController3, context),
                            SizedBox(width: 12),
                        _OTPField(otpController4, context),
                      ]),

                      // Container(
                      //   child: TextField(
                      //     controller: otpController,
                      //     keyboardType: TextInputType.phone,
                      //     decoration: InputDecoration(
                      //       contentPadding: EdgeInsets.all(20),
                      //       border: OutlineInputBorder(
                      //           borderSide: BorderSide(color: Colors.grey)),
                      //       hintText: "Mobile Number",
                      //       prefixIcon: Padding(
                      //         padding: const EdgeInsets.symmetric(
                      //             horizontal: 12.0, vertical: 12),
                      //         child: Text(
                      //           "+91",
                      //           style: TextStyle(fontSize: 15),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 65,
                      ),
                      Text(
                        "Didn't receive OTP?",
                        style: TextStyle(fontWeight: FontWeight.w200),
                      ),
                      Text(
                        "Resend OTP in ",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  model.isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () async {
                            final enteredOTP = otpController1.text.trim() +
                                otpController2.text.trim() +
                                otpController3.text.trim() +
                                otpController4.text.trim();
                            model.otp = enteredOTP;
                            await model.verifyOTP(context, phoneNumber);
                          },
                          child: Text("Verify OTP")),
                ],
              ),
            ),
          )),
    );
  }

  Widget _OTPField(TextEditingController controller, BuildContext context) {
    return SizedBox(
      width: 50,
      height: 55,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
