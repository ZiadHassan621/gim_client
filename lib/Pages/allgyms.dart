import 'package:flutter/material.dart';
import 'package:gim_client/Constant/linkapi.dart';
import 'package:gim_client/Crud/crud.dart';
import 'package:gim_client/Database/localdata.dart';
import 'package:gim_client/MyWidget/myTextfield.dart';
import 'package:gim_client/MyWidget/mycardallgym.dart';
import 'package:gim_client/Pages/multipages.dart';

class ReviewAllGym extends StatefulWidget {
  const ReviewAllGym({super.key});

  @override
  State<ReviewAllGym> createState() => _ReviewAllGymState();
}

class _ReviewAllGymState extends State<ReviewAllGym> {
  TextEditingController gymName = TextEditingController();

  void _showModalBottomSheet() {
    showModalBottomSheet(
      backgroundColor: const Color.fromARGB(255, 48, 44, 44),
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          height: 550,
          width: 450,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Add a new gym",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 16),
              MyTextField(
                  controller: gymName,
                  secureText: false,
                  labeltext: "Add a new gym",
                  hinttext: "gym name...."),
              const SizedBox(height: 16),
              ElevatedButton(
                  child: const Text("Confirm"),
                  onPressed: () {
                    setState(() {
                      createanewgym();
                    });

                    Navigator.of(context).pop();
                  }),
            ],
          ),
        );
      },
    );
  }

  List myWidget = [];
  Crud _crud = Crud();
  LocalData data = LocalData();

  @override
  void initState() {
    // TODO: implement initState
    //initilaize();
    super.initState();
  }

  createanewgym() async {
    var readtoken = await data.readtoken();
    var response = await _crud.postDatatocreategym(
        linkcreategym, {"gymName": gymName.text}, readtoken['AccessToken']);
    if (response["StatusCode"] == 200 || response["StatusCode"] == 201) {
      setState(() {
        initilaize();
        gymName.clear();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response["ResponseBody"]['message'])));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response["ResponseBody"]['error'])));
    }
  }

  deletegymById(int id) async {
    var readtoken = await data.readtoken();
    var response = await _crud.deleteGymbyId(
        "https://gim-api.vercel.app/gim/v1/gyms/$id", readtoken['AccessToken']);
    if (response["ResponseBody"] == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response["ResponseBody"]['message'])));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response["ResponseBody"]['error'])));
    }
    setState(() {});
  }

  initilaize() async {
    var readtoken = await data.readtoken();
    var response = await _crud.getData(linkgetgym, readtoken['AccessToken']);
    if (response["StatusCode"] == 200) {
      var raw = response["ResponseBody"];

      return raw;
      // for (var raw in raw) {
      //   setState(() {
      //     myWidget.add(Mycardallgym(
      //       gymname: raw["gymName"],
      //       onTap: () {
      //         Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => MultiPagesNav(
      //                 id: raw["gymId"],
      //               ),
      //             ));
      //         // Navigator.pushNamed(context, '/multipages');
      //       },
      //     ));
      //   });
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _showModalBottomSheet();
            });
          },
          child: const Icon(Icons.add),
        ),
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "Select one of ......",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: FutureBuilder(
            future: initilaize(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                List gyms = snapshot.data;
                return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Mycardallgym(
                            gymname: gyms[index]["gymName"],
                            onPressed: (p0) {
                              setState(() {
                                deletegymById(gyms[index]["gymId"]);
                              });
                            },
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MultiPagesNav(
                                            id: gyms[index]["gymId"],
                                          )));
                            });
                      },
                      itemCount: gyms.length,
                    ));
              } else {
                return const Text('No data available');
              }
            },
          ),
        ));
  }
}
