import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/login/register.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home.dart';
import '../theme.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        // Save login status
        await saveLoginStatus(true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      } catch (e) {
        Get.snackbar(
          "Login Error",
          _getFirebaseErrorMessage(e),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  Future<void> saveLoginStatus(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', isLoggedIn);
  }

  Future<void> resetPassword() async {
    if (emailController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter your email to reset password",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    try {
      await _auth.sendPasswordResetEmail(email: emailController.text.trim());
      emailController.clear(); // Clear the email field after sending the email
      Get.snackbar(
        "Success",
        "Password reset email sent! Check your inbox.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        _getFirebaseErrorMessage(e),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _showResetPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Reset Password', style: TextStyle(fontWeight: FontWeight.bold)),
          content: TextField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'Enter your email',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email, color: Colors.orange),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await resetPassword();
              },
              child: Text('Reset', style: TextStyle(color: Colors.orange)),
            ),
          ],
        );
      },
    );
  }

  String _getFirebaseErrorMessage(dynamic e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'invalid-email':
          return 'The email address is not valid.';
        case 'user-not-found':
          return 'No user found for that email.';
        case 'wrong-password':
          return 'Wrong password provided for that user.';
        default:
          return 'An error occurred. Please try again.';
      }
    }
    return 'An unknown error occurred. Please try again.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Text(
              "Welcome To Foodie",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Image(
              width: 120,
                height: 120,
                image: AssetImage("assets/images/foodie.jpg")),
            // Image.asset('assets/images/foodie.png', height: 50), // Add your logo here
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email, color: Colors.orange),
                      hintStyle: TextStyle(color: Colors.grey),
                      fillColor: Colors.black.withOpacity(0.5),
                      filled: true,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock, color: Colors.orange),
                      hintStyle: TextStyle(color: Colors.grey),
                      fillColor: Colors.black.withOpacity(0.5),
                      filled: true,
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _showResetPasswordDialog,
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.orange, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: signIn,
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                    },
                    child: Text(
                      "Don't have an account? Sign up",
                      style: TextStyle(fontSize: 16, color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
