import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/welcome.dart';
import 'package:provider/provider.dart';

import 'helpers/cart_handler.dart';

void main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDGAyBE4smBN2Lu0_RINPYfg7U0ElTrLMc",
          appId: "1:589008208547:android:c9bca32999b5119f4ff516",
          messagingSenderId: "",
          projectId: "fooddelivery-ef043",
          storageBucket: "fooddelivery-ef043.appspot.com")
  );
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        // Other providers
      ],
    child:MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
