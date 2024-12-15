import 'package:flutter/material.dart';
import 'package:gim_client/Constant/linkapi.dart';
import 'package:gim_client/Crud/crud.dart';
import 'package:gim_client/Database/localdata.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final Crud _crud = Crud();
  LocalData data = new LocalData();
  @override
  void initState() {
    initilation();
    super.initState();
  }

  void verfiyData() async {
    var readtoken = await data.readtoken();
    if (readtoken['RefreshToken'] == null) {
      Navigator.pushReplacementNamed(context, '/Login');
    }
    var response = await _crud
        .postData(linktoken, {'refreshToken': readtoken['RefreshToken']});
    if (response['StatusCode'] == 200) {
      await data.deleteAccesstoken();
      print(response['ResponseBody']);
      await data.writeAccesstoken(response['ResponseBody']['accessToken']);
      var checkGym = await _crud.getData(linkgetgym, readtoken['AccessToken']);
      if (checkGym['StatusCode'] == 200) {
        Navigator.pushReplacementNamed(context, '/multipages');
      } else {
        Navigator.pushReplacementNamed(context, '/CreateFristGym');
        // goto Create GYM Page
      }
      // Navigator.pushReplacementNamed(context, '/multipages');
    } else {
      Navigator.pushReplacementNamed(context, '/Login');
    }
  }

  void initilation() async {
    await Future.delayed(
      const Duration(seconds: 2),
      () {
        verfiyData();

        // here to implement that user have token or not know that from backend
        //if this user have token at database go to dashboard
        //Navigator.pushReplacementNamed(context, '/bottomnav');
        // else if this user not have token at database go to login screen
        //Navigator.pushReplacementNamed(context, '/Login');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            "GIM",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 34, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
