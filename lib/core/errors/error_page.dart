import 'package:flutter/material.dart';

class RootError extends StatelessWidget {
  const RootError({
    super.key,
    required this.message,
  });
  final String message;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title:const Text('Something went wrong!'),
        ),
        body: Center(
          child: Text(message),
        ),
      ),
    );
  }
}