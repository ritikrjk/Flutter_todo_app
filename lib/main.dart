import 'package:flutter/material.dart';
import 'package:flutter_dodo/screens/home_page.dart';
import 'package:flutter_dodo/screens/intro_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {


    
    return MaterialApp(home: IntroPage(),
    
    routes: {
      "homepage":(context) => HomePage(),
    },
    );

    
  }
}
