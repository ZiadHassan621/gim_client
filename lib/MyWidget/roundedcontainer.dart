// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  RoundedContainer({
    super.key,
    required this.icon,
    this.onTap,
  });
  final Icon? icon;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 33, 33, 33),
            borderRadius: BorderRadius.circular(100)),
        child: icon,
      ),
    );
  }
}
