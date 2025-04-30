import 'package:flutter/material.dart';
import 'widgets/main_navigation.dart'; // Import the new component

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
      home: MainNavigation(),
    );
  }
}
