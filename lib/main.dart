import 'package:flutter/material.dart';
import 'package:ngo_app/features/widgets/custom_bottom_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NGO App',
      home: CustomBottomNavigationBar(),
    );
  }
}
