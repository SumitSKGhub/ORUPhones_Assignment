import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oruphones/ui/views/auth/auth_viewmodel.dart';
import 'package:oruphones/ui/views/home/home_viewmodel.dart';
import 'package:oruphones/ui/widgets/stretched_button.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  final HomeViewModel? homeViewModel;
  final BuildContext? contextHome;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final bool isBottomSheet;

  LoginView(
      {super.key,
      this.isBottomSheet = false,
      this.homeViewModel,
      this.contextHome});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>.reactive(
        viewModelBuilder: () => AuthViewModel(),
        builder: (context, model, child) {
          final Widget loginContent = SizedBox(
            // padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize:
                    isBottomSheet ? MainAxisSize.min : MainAxisSize.max,
                children: [
                  isBottomSheet
                      ? Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Sign in to continue",
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
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/home');
                                    },
                                    child: Icon(Icons.close))),
                            SizedBox(
                              height: 40,
                            ),
                            Image.asset(
                              "assets/images/logo/logo_login.png",
                              fit: BoxFit.fitWidth,
                              height: 80,
                              width: 150,
                            ),
                            SizedBox(
                              height: 80,
                            ),
                            Text(
                              "Welcome",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                  color: Color(0xFF3F3E8F)),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                "Sign in to continue",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 120,
                            ),
                          ],
                        ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Enter Your Phone Number",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Container(
                          child:
                              // isBottomSheet
                              //   ? TextField(
                              //   keyboardType: TextInputType.phone,
                              //   decoration: InputDecoration(labelText: "Phone"),
                              // )
                              // :
                              TextFormField(
                            key: ValueKey("value"),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Number cannot be empty!";
                              }
                              return null;
                            },
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              hintText: "Mobile Number",
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 12),
                                child: Text(
                                  "+91",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CheckboxListTile(
                    value: model.tick,
                    title: Row(
                      children: [
                        Text("Accept "),
                        Text(
                          "Terms and condition",
                          style: TextStyle(
                              color: Color(0xFF3F3E8F),
                              decoration: TextDecoration.underline),
                        )
                      ],
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (value) {
                      model.acceptTerms();
                    },
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
                            onPressed: () {
                              if (isBottomSheet) {
                                if (_formKey.currentState!.validate()) {
                                  model.phoneNumber = phoneController.text;
                                  model.contextHome = contextHome;
                                  model.sendOTP(context,true);
                                }
                                Navigator.pop(context);
                                // model.launchOTPVerifyBottomSheet(
                                //     contextHome!, model.phoneNumber!);
                              } else {
                                if (_formKey.currentState!.validate()) {
                                  print("I m not a bottom sheet");
                                  model.phoneNumber = phoneController.text;
                                  model.sendOTP(context,false);
                                }
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Next",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 19),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );

          if (isBottomSheet) return loginContent;

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: loginContent,
            )),
          );
        });
  }
}
