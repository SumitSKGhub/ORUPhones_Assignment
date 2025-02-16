import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oruphones/ui/views/auth/auth_viewmodel.dart';
import 'package:stacked/stacked.dart';

class VerifyOtpView extends StatelessWidget {
  final bool isBottomSheet;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController otpController1 = TextEditingController();
  final TextEditingController otpController2 = TextEditingController();
  final TextEditingController otpController3 = TextEditingController();
  final TextEditingController otpController4 = TextEditingController();

  VerifyOtpView(
      {super.key, this.isBottomSheet = false});

  @override
  Widget build(BuildContext context) {
    final String phoneNumber =
        ModalRoute.of(context)!.settings.arguments as String;

    return ViewModelBuilder<AuthViewModel>.reactive(
        viewModelBuilder: () => AuthViewModel(),
        builder: (context, model, child) {
          final Widget verifyScreen = SizedBox(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize:
                    isBottomSheet ? MainAxisSize.min : MainAxisSize.max,
                children: [
                  !isBottomSheet
                      ? Column(
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
                          ],
                        )
                      : Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Verify OTP",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      // Navigator.pushNamed(context, '/home');
                                      Navigator.pop(context);
                                    },
                                    child: Icon(Icons.close)),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(),
                            SizedBox(
                              height: 25,
                            )
                          ],
                        ),
                  Text(
                    textAlign: TextAlign.center,
                    "Please enter the 4 digit verification code sent to you mobile number +91-${phoneNumber} via SMS",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: !isBottomSheet ? 120 : 20,
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
                        height: !isBottomSheet ? 65 : 40,
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
                    height: !isBottomSheet ? 60 : 20,
                  ),
                  model.isLoading
                      ? CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          height: 62,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              // fixedSize:WidgetStateProperty.all<Size?>(Size(500.0, 70.0)),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              backgroundColor: Color(0xFF3F3E8F),
                            ),
                            onPressed: () async {
                              final enteredOTP = otpController1.text.trim() +
                                  otpController2.text.trim() +
                                  otpController3.text.trim() +
                                  otpController4.text.trim();
                              if (enteredOTP == '') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("Invalid OTP! Try Again.")));
                              } else {
                                model.otp = enteredOTP;
                                await model.verifyOTP(context, phoneNumber);
                              }
                            },
                            child: Text(
                              "Verify OTP",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 19),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );

          if (isBottomSheet) return verifyScreen;

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
                child: Padding(
              padding: EdgeInsets.all(16),
              child: verifyScreen,
            )),
          );
        });
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
