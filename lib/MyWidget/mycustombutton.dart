// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyCustomButton extends StatelessWidget {
  MyCustomButton(
      {super.key,
      this.onTap,
      this.mycontainercolor,
      this.myIcon,
      this.myIconColor,
      this.myTextColor,
      required this.borderwidth,
      required this.myText});
  Color? mycontainercolor;
  IconData? myIcon;
  Color? myIconColor;
  Color? myTextColor;
  final String myText;
  final double borderwidth;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 18),
        width: 60,
        height: 45,
        decoration: BoxDecoration(
            border: Border.all(width: borderwidth, color: Colors.grey),
            color: mycontainercolor,
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              myIcon,
              color: myIconColor,
              size: 26,
              fill: 1,
              weight: 60,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              myText,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: myTextColor),
            )
          ],
        ),
      ),
    );
  }
}
