import 'dart:convert';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:oruphones/core/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final String baseUrl = "http://40.90.224.241:5000";

  Future<bool> checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    String? authCookie = prefs.getString("auth_cookie");

    if (authCookie == null) return false;

    final response = await http.get(
      Uri.parse("$baseUrl/isLoggedIn"),
      headers: {
        "Cookie": authCookie ?? "",
      },
    );

    if(response.statusCode == 200){
      return jsonDecode(response.body)["isLoggedIn"];
    }

    return false;
  }

  Future<bool> sendOTP(String phoneNumber) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login/otpCreate"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
          {"countryCode": 91, "mobileNumber": int.parse(phoneNumber)}),
    );
    print(response.body);
    return response.statusCode == 200;
  }

  Future<bool> verifyOTP(String phoneNumber, String otp) async {
    print("Service-otp: " + otp);
    final response = await http.post(
      Uri.parse("$baseUrl/login/otpValidate"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "countryCode": 91,
        "mobileNumber": int.parse(phoneNumber),
        "otp": int.parse(otp)
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("Verified?: " + data.toString());

      print("Header: ");
      print(response.headers);

      final cookie = response.headers['set-cookie'];
      if (cookie != null) {
        print(cookie);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("auth_cookie", cookie);
      }

      // final prefs = await SharedPreferences.getInstance();
      // await prefs.setString("csrf_token", data["csrf_token"]);
      // await prefs.setString("auth_cookie", data["auth_cookie"]);
      return true;
    }
    return false;
  }

  Future<Map<String, dynamic>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? authCookie = prefs.getString("auth_cookie");

    final response = await http.get(
      Uri.parse("$baseUrl/isLoggedIn"),
      headers: {
        "Cookie": authCookie ?? "",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print("Logged In or Not?: " + data["user"].toString());
      print(data["favListings"]);

      await prefs.setString("csrf_token", data['csrfToken']);

      return data;
    } else {
      return {};
    }
  }

  Future<bool> updateUserName(String userName) async {
    final prefs = await SharedPreferences.getInstance();
    String? csrfToken = prefs.getString("csrf_token");
    String? authCookie = prefs.getString("auth_cookie");
    print(csrfToken);

    final response = await http.post(
      Uri.parse("$baseUrl/update"),
      headers: {
        "Content-Type": "application/json",
        "X-Csrf-Token": csrfToken ?? "",
        "Cookie": authCookie ?? "",
      },
      body: jsonEncode({
        "countryCode": 91,
        "userName": userName,
      }),
    );

    print("Response: ");
    print(response.body);
    return response.statusCode == 200;
  }

  Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? authCookie = prefs.getString("auth_cookie");

    try {
      final response = await http.get(
        Uri.parse("$baseUrl/isLoggedIn"),
        headers: {
          "Cookie": authCookie ?? "",
        },
      );
      final Map<String, dynamic> userData = jsonDecode(response.body);
      print("User Data: ");
      print(userData);
      return UserModel.fromJson(userData["user"]);
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    String? csrfToken = prefs.getString("csrf_token");

    await http.get(
      Uri.parse("$baseUrl/logout"),
      headers: {"X-Csrf-Token": csrfToken ?? ""},
    );

    await prefs.remove("auth_cookie");
    await prefs.remove("csrf_token");

  }

  Future<void> signOut() async {
    // await _auth.signOut();
  }
}
