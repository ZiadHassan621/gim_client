import 'package:flutter/material.dart';
import 'package:gim_client/Constant/linkapi.dart';
import 'package:gim_client/Crud/crud.dart';
import 'package:gim_client/Database/localdata.dart';
import 'package:gim_client/MyWidget/myTextfield.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({
    super.key,
  });

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  LocalData data = LocalData();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();

  // Crud _crud = Crud();
  final Crud _crud = Crud();

  signup() async {
    var response = await _crud.postData(linkSignup, {
      "username": username.text,
      "name": name.text,
      "email": email.text,
      "password": pass.text
    });
    if (response['StatusCode'] == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response["ResponseBody"]['success'])));
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushNamed(context, '/Login');
      });
    } else if (response['StatusCode'] == 400) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['ResponseBody']['error'])));
    } else if (response['StatusCode'] == 500) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['ResponseBody']['error'])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0000),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            height: 600,
            width: 350,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[800]!, width: 2),
                borderRadius: BorderRadius.circular(35)),
            child: Column(children: [
              const Padding(padding: EdgeInsets.all(12)),
              const Text(
                "Sign Up",
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
              const SizedBox(
                height: 40,
              ),
              MyTextField(
                controller: username,
                secureText: false,
                labeltext: 'Enter username',
                hinttext: 'Enter Your username',
              ),
              MyTextField(
                controller: name,
                secureText: false,
                labeltext: 'Enter your name',
                hinttext: 'Enter your name',
              ),
              MyTextField(
                controller: email,
                secureText: false,
                labeltext: 'Enter Email',
                hinttext: 'Enter Your Email',
              ),
              MyTextField(
                controller: pass,
                secureText: true,
                labeltext: 'Enter Password',
                hinttext: 'Enter Your Password',
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  signup();
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
                child: const Text("Sign up"),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 12,
                          fontWeight: FontWeight.w200),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/Login');
                      },
                      child: const Text(
                        "  Sign In",
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
