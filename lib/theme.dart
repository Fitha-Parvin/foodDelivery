import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData appTheme() => ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        primaryColor: AppColor.primaryColor,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent, elevation: 0.0),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColor.primaryColor,
          foregroundColor: AppColor.primaryColor,
        ),
        iconTheme: const IconThemeData(
          size: 18.0,
          color: AppColor.primaryColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor,
                elevation: 20.0,
                shadowColor: AppColor.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),),),
        textTheme: const TextTheme(
          //testo per descrizioni
          bodyLarge: TextStyle(
            color: AppColor.descriptionColor,
            fontWeight: FontWeight.normal,
            fontSize: 18
          ),
          //testo per i titoli
          bodyMedium: TextStyle(
            color: AppColor.titleTextColor,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
          //testo per i sottotitoli
          displayLarge: TextStyle(
            color: AppColor.titleTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),// colorScheme: const ColorScheme(background: AppColor.transparentColor, brightness: null, primary: null, onPrimary: null, secondary: null),
      );
}

extension AppColor on Colors {
  //green
  static const primaryColor = Colors.orange;
  //light grey for text on description
  static const descriptionColor = Color(0XFF9E9E9E);
  //black for Title text
  static const titleTextColor = Color(0xFF061737);
  //transparent
  static const transparentColor = Color(0xFFC4C4C4);
  //color light for drawing background
  static const figureBckColor = Colors.black;
}
const textboxColor=Colors.yellow;