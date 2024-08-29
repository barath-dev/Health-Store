import 'package:flutter/material.dart';
import 'package:hospital/core/utils/shared_pref.dart';
import 'package:hospital/presentation/Auth/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SharedPrefs.getAuthToken() == null
          ? const LoginScreen()
          : const HomeScreen(),
    );
  }
}
