import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Mycardallgym extends StatelessWidget {
  Mycardallgym({
    required this.gymname,
    this.onTap,
    this.onPressed,
    super.key,
  });
  String gymname;
  void Function()? onTap;
  void Function(BuildContext)? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Slidable(
        startActionPane: ActionPane(motion: const ScrollMotion(), children: [
          SlidableAction(
            onPressed: onPressed,
            icon: Icons.delete,
            backgroundColor: Colors.red[500]!,
            borderRadius: BorderRadius.circular(12),
          )
        ]),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[900],
          ),
          child: ListTile(
            onTap: onTap,
            title: Text(
              gymname,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(12)),
              child: Center(
                  child: Text(
                gymname[0],
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              )),
            ),
          ),
        ),
      ),
    );
  }
}
