import 'package:flutter/material.dart';
import 'package:gim_client/Pages/createfristgym.dart';
import 'package:gim_client/Pages/multipages.dart';
import 'package:gim_client/Pages/dasboard.dart';
import 'package:gim_client/Pages/loginpage.dart';
import 'package:gim_client/Pages/signup.dart';
import 'package:gim_client/splashscreen.dart';

void main() {
  runApp(const GymManagmentSystem());
}

class GymManagmentSystem extends StatelessWidget {
  const GymManagmentSystem({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Splashscreen(),
      routes: {
        '/Signup': (context) => const Sign_up(),
        '/Login': (context) => const LoginPage(),
        '/dashboard': (context) => const DashBoard(),
        '/multipages': (context) => const MultiPagesNav(),
        '/CreateFristGym': (context) => const CreateFristGym()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
