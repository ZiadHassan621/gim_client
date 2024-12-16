import 'package:flutter/material.dart';
import 'package:gim_client/Constant/linkapi.dart';
import 'package:gim_client/Crud/crud.dart';
import 'package:gim_client/Database/localdata.dart';
import 'package:gim_client/MyWidget/myTextfield.dart';
import 'package:gim_client/Pages/allgyms.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Crud _crud = Crud();
  LocalData data = LocalData();
  bool isLoading = true;

  TextEditingController identifier = TextEditingController();
  TextEditingController pass = TextEditingController();
  login() async {
    var readtoken = await data.readtoken();
    var response = await _crud.postData(
        linkLogin, {"identifier": identifier.text, "password": pass.text});
    if (response['StatusCode'] == 200) {
      await data.deleteAlltoken();
      await data.writetoken(response["ResponseBody"]['accessToken'],
          response["ResponseBody"]['refreshToken']);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => ReviewAllGym()),
        (Route<dynamic> route) => false,
      );

      //   // goto Create GYM Page
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['ResponseBody']['error'])));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0x00000000),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                height: 520,
                width: 350,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[800]!, width: 2),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Login",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                        const SizedBox(height: 20),
                        MyTextField(
                          controller: identifier,
                          secureText: false,
                          labeltext: 'Enter Email Address',
                          hinttext: 'Enter Your email address',
                        ),
                        MyTextField(
                          controller: pass,
                          secureText: true,
                          labeltext: 'Enter Password',
                          hinttext: 'Enter Your Password',
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            login();
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.deepPurple,
                            padding: const EdgeInsets.all(10.0),
                            fixedSize: const Size(250, 60),
                            textStyle: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          child: const Text("Log In"),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/Signup');
                            },
                            child: const Text(
                              "Create a new account....",
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
