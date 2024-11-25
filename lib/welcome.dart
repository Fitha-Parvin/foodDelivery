import 'package:flutter/material.dart';
import 'package:food_delivery/theme.dart';

import 'login/login.dart';


class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/welcome.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 20,
              top: MediaQuery.of(context).size.height * 0.1, // Responsive top position
              child: Text(
                "Super\nDelicious\nFood",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black.withOpacity(0.7),
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 50, // Responsive bottom position
              left: MediaQuery.of(context).size.width * 0.3, // Responsive left position
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Text(
                  "GET STARTED",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: textboxColor, // Button background color
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
