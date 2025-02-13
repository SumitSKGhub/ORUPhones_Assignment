import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oruphones/ui/views/auth/auth_viewmodel.dart';
import 'package:oruphones/ui/widgets/stretched_button.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>.reactive(
      viewModelBuilder: () => AuthViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text("Login"),
          ),
          body: 
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
                    "Welcome",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: Color(0xFF3F3E8F)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
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
              
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enter Your Phone Number",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Container(
                        child: TextField(
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
                      :
                  // InkWell(
                  //         onTap: () {
                  //           model.phoneNumber = phoneController.text;
                  //           model.sendOTP(context);
                  //         },
                  //         child: StretchedButton(
                  //           text: "Next",
                  //           icon: true,
                  //         )),

                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: TextButton(
                  //               style: ButtonStyle(
                  //                 // fixedSize:WidgetStateProperty.all<Size?>(Size(500.0, 70.0)),
                  //                 backgroundColor:
                  //                     WidgetStateProperty.all<Color>(Color(0xFF3F3E8F)),
                  //               ),
                  //               onPressed: () {},
                  //               child: Text(
                  //                 "Next",
                  //                 style: TextStyle(color: Colors.white),
                  //               )),
                  //     ),
                  //   ],
                  // ),

                  ElevatedButton(
                          onPressed: () {
                            model.phoneNumber = phoneController.text;
                            model.sendOTP(context);
                          },
                          child: Text("Send OTP")),
                ],
              ),
            ),
          )
      ),
    );
  }
}
