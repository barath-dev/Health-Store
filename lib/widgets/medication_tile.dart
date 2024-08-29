import 'package:flutter/material.dart';
import 'package:hospital/widgets/custom_textfield.dart';

class MedicineTile extends StatefulWidget {
  const MedicineTile({super.key});

  @override
  State<MedicineTile> createState() => _MedicineTileState();
}

class _MedicineTileState extends State<MedicineTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(hintText: "Medicine Name"),
        const SizedBox(height: 20),
        Row(
          children: [
            const SizedBox(width: 20),
            CustomTextFormField(
              hintText: "Dosage",
              width: MediaQuery.of(context).size.width / 2 - 30,
            ),
            const SizedBox(width: 20),
            CustomTextFormField(
                hintText: "Frequency",
                width: MediaQuery.of(context).size.width / 2 - 30),
            const SizedBox(width: 20),
          ],
        ),
        const SizedBox(height: 20),
        CustomTextFormField(hintText: "Reason"),
        const SizedBox(height: 20),
        CustomTextFormField(hintText: "Remarks"),
      ],
    );
  }
}
