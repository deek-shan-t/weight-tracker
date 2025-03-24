import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(WeightTrackingApp());
}

class WeightTrackingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: HomeScreen(),
    );
  }
}
