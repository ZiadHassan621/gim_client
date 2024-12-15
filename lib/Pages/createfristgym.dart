import 'package:flutter/material.dart';
import 'package:gim_client/Constant/linkapi.dart';
import 'package:gim_client/Crud/crud.dart';
import 'package:gim_client/Database/localdata.dart';
import 'package:gim_client/MyWidget/myTextfield.dart';
import 'package:gim_client/MyWidget/mycustombutton.dart';

class CreateFristGym extends StatefulWidget {
  const CreateFristGym({super.key});

  @override
  State<CreateFristGym> createState() => _CreateFristGymState();
}

class _CreateFristGymState extends State<CreateFristGym> {
  TextEditingController gymname = TextEditingController();
  final Crud _crud = Crud();
  LocalData data = LocalData();

  void creategym() async {
    var readtoken = await data.readtoken();
    var response = await _crud.postDatatocreategym(
        linkcreategym, {"gymName": gymname.text}, readtoken['AccessToken']);
    print(response["StatusCode"]);
    print(response["ResponseBody"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Text(
          "Create a gym",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            MyTextField(
                controller: gymname,
                secureText: false,
                labeltext: "Gym name",
                hinttext: "Enter Gym name"),
            MaterialButton(
              onPressed: () async {
                creategym();
              },
              child: const Text(
                "Confirm",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
