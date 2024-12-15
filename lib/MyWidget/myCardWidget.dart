import 'package:flutter/material.dart';

class MyCardWidget extends StatelessWidget {
  const MyCardWidget({
    super.key,
    required this.firsticons,
    required this.seconedicons,
    required this.nameOfCard,
    required this.firstcontentOfcard,
    required this.seconedcontentOfcard,
    required this.thirdcontentOfcard,
    required this.smallcontainer,
  });
  final IconData firsticons;
  final Icon seconedicons;
  final String nameOfCard;
  final String firstcontentOfcard;
  final String seconedcontentOfcard;
  final String thirdcontentOfcard;
  final Color smallcontainer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(top: 14),
      width: 60,
      height: 160,
      decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                firsticons,
                color: const Color.fromARGB(255, 157, 157, 157),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                nameOfCard,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color.fromARGB(255, 157, 157, 157)),
              )
            ],
          ),
          Row(
            children: [
              Text(firstcontentOfcard,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white)),
              Container(
                margin: const EdgeInsets.only(left: 24),
                width: 100,
                height: 35,
                decoration: BoxDecoration(
                    // change the color here
                    //
                    //
                    //
                    //
                    //
                    //
                    color: smallcontainer,
                    borderRadius: BorderRadius.circular(18)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.track_changes),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      seconedcontentOfcard,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          ),
          Text(
            thirdcontentOfcard,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color.fromARGB(255, 157, 157, 157)),
          )
        ],
      ),
    );
  }
}
