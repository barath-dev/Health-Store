import 'package:flutter/material.dart';
import 'package:hospital/widgets/medication_tile.dart';

class AddPrescription extends StatefulWidget {
  const AddPrescription({super.key});

  @override
  State<AddPrescription> createState() => _AddPrescriptionState();
}

class _AddPrescriptionState extends State<AddPrescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Prescription"),
      ),
      body: const SafeArea(
          minimum: EdgeInsets.all(7.5),
          left: true,
          right: true,
          child: Column(children: [
            MedicineTile(),
          ])),
    );
  }
}
