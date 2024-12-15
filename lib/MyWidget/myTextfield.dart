import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  MyTextField(
      {super.key,
      required this.controller,
      required this.secureText,
      required this.labeltext,
      required this.hinttext});
  bool secureText;
  String labeltext;
  String hinttext;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          obscureText: secureText,
          controller: controller,
          decoration: InputDecoration(
            //fillColor: Color.fromRGBO(255, 255, 255, 1),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            labelText: labeltext,
            //labelStyle: TextStyle(color: Color.fromRGBO(179, 0, 0, 1)),
            hintText: hinttext,
            //hintStyle: TextStyle(color: Color.fromRGBO(255, 255, 255, 1))
          ),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
