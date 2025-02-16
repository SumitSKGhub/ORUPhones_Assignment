import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oruphones/ui/views/auth/auth_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ConfirmNameView extends StatelessWidget {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>.reactive(
      viewModelBuilder: () => AuthViewModel(),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
          ),
          backgroundColor: Colors.white,
          body: Container(
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
                      "SignUp to continue",
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
                        "Please Tell Us Your Name *",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Container(
                        child: TextField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            hintText: "Name",
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
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
                              model.updatedUserName = nameController.text;
                              model.updateUserName(context);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Confirm Name",
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
                  // ElevatedButton(
                  //         onPressed: () {
                  //           model.updatedUserName = nameController.text;
                  //           model.updateUserName(context);
                  //         },
                  //         child: Text("Confirm Name")),
                ],
              ),
            ),
          )),
    );
  }
}
