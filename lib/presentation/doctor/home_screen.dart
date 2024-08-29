import 'package:flutter/material.dart';
import 'package:hospital/presentation/doctor/add_prescription.dart';

class DocHomeScreen extends StatefulWidget {
  const DocHomeScreen({super.key});

  @override
  State<DocHomeScreen> createState() => _DocHomeScreenState();
}

class _DocHomeScreenState extends State<DocHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctor Home Screen"),
      ),
      body: Center(
        child: Container(
          child: const Text("Doctor Home Screen"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddPrescription(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
