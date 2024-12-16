import 'package:flutter/material.dart';
import 'package:gim_client/Constant/linkapi.dart';
import 'package:gim_client/Crud/crud.dart';
import 'package:gim_client/Database/localdata.dart';
import 'package:gim_client/MyWidget/myCardWidget.dart';
import 'package:gim_client/MyWidget/mycustombutton.dart';
import 'package:gim_client/MyWidget/roundedcontainer.dart';
import 'package:gim_client/Pages/loginpage.dart';
import 'package:intl/intl.dart';

class DashBoard extends StatefulWidget {
  DashBoard({super.key, this.id});
  int? id;

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  String? formattedDate;
  final Crud _crud = Crud();
  LocalData data = new LocalData();
  bool isLoading = true;
  @override
  void initState() {
    DateTime now = DateTime.now();
    formattedDate = DateFormat('dd / MM / yyyy').format(now);
    // Future.delayed(Duration(seconds: 2), () {
    //   setState(() {
    //     isLoading = false;
    //   });
    // });
    super.initState();
  }

  logout(String refreshtoken, String accesstoken) async {
    await _crud.deleteData(linklogout, refreshtoken, accesstoken);
    await data.deleteAlltoken();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false,
    );
    // Navigator.pushNamedAndRemoveUntil(context, '/Login');
    // var response =
    //     await _crud.deleteData(linklogout, refreshtoken, accesstoken);
    // if (response["StatusCode"] == 204) {
    //   print("Ziaaaaaaaaaaadddddddd");
    //   Navigator.pushReplacementNamed(context, '/Login');
    // } else if (response["StatusCode"] == 500 || response["StatusCode"] == 400) {
    //   print("aloooooooooooooooooooooooooooooooo");
    //   print(response["ResponseBody"]);
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text(response["ResponseBody"])));
    // }
  }

  getgymbyid(int id) async {
    var readtoken = await data.readtoken();
    var response = await _crud.getData(
        "https://gim-api.vercel.app/gim/v1/gyms/$id", readtoken['AccessToken']);
    // print(response["ResponseBody"]);
    // print(response["StatusCode"]);
    return response["ResponseBody"];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(0, 0, 0, 255),
        body: Center(
            child: FutureBuilder(
          future: getgymbyid(widget.id!),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // While waiting
            } else if (snapshot.hasError) {
              return Center(
                  child:
                      Text('Error: ${snapshot.error}')); // If there's an error
            } else if (snapshot.hasData) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 235, 71, 62),
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                              child: Text(
                            snapshot.data["gymName"][0],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          )),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(snapshot.data["gymName"],
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 247, 247, 247))),
                            const SizedBox(
                              height: 6,
                            ),
                            const Text("Gym Management",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 165, 165, 165)))
                          ],
                        ),
                        const SizedBox(
                          width: 62,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            RoundedContainer(
                                onTap: () async {
                                  print(await data.readtoken());
                                },
                                icon: const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                )),
                            const SizedBox(
                              width: 8,
                            ),
                            RoundedContainer(
                                onTap: () {},
                                icon: const Icon(
                                  Icons.notifications,
                                  color: Colors.white,
                                )),
                            const SizedBox(
                              width: 8,
                            ),
                            RoundedContainer(
                                onTap: () async {
                                  var tokens = await data.readtoken();
                                  logout(tokens['RefreshToken'],
                                      tokens['AccessToken']);
                                },
                                icon: const Icon(
                                  Icons.login,
                                  color: Colors.white,
                                ))
                          ],
                        )
                      ],
                    ),
                    Container(
                      height: 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Manage your Gym ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        const Text("members",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25)),
                        Container(
                          height: 6,
                        ),
                        Text(formattedDate!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14))
                      ],
                    ),
                    MyCustomButton(
                      onTap: () {},
                      borderwidth: 0,
                      myIcon: Icons.add,
                      myIconColor: const Color.fromARGB(255, 0, 7, 0),
                      myTextColor: const Color.fromARGB(255, 0, 7, 0),
                      mycontainercolor:
                          const Color.fromARGB(255, 185, 241, 116),
                      myText: 'New member',
                    ),
                    MyCustomButton(
                      borderwidth: 1,
                      myText: 'Manage Branches',
                      myTextColor: const Color.fromARGB(255, 229, 232, 225),
                      mycontainercolor: Colors.black,
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    const MyCardWidget(
                      nameOfCard: 'Revenue',
                      firsticons: Icons.account_balance,
                      firstcontentOfcard: '\$4,57K',
                      seconedcontentOfcard: '2.1%',
                      seconedicons: Icon(Icons.track_changes),
                      smallcontainer: Color.fromARGB(255, 48, 250, 152),
                      thirdcontentOfcard: 'Month/October',
                    ),
                    const MyCardWidget(
                      nameOfCard: 'Members',
                      firsticons: Icons.person_2_outlined,
                      firstcontentOfcard: '89',
                      seconedcontentOfcard: '1.8%',
                      seconedicons: Icon(Icons.track_changes),
                      smallcontainer: Color.fromARGB(255, 255, 79, 82),
                      thirdcontentOfcard: 'Active members',
                    ),
                    const MyCardWidget(
                      nameOfCard: 'Last visited',
                      firsticons: Icons.alarm_outlined,
                      firstcontentOfcard: '56',
                      seconedcontentOfcard: '1.2%',
                      seconedicons: Icon(Icons.track_changes),
                      smallcontainer: Color.fromARGB(255, 255, 79, 82),
                      thirdcontentOfcard: 'Daily average',
                    ),
                    const MyCardWidget(
                      nameOfCard: 'Coach',
                      firsticons: Icons.person_outline_sharp,
                      firstcontentOfcard: '12',
                      seconedcontentOfcard: '3.6%',
                      seconedicons: Icon(Icons.track_changes),
                      smallcontainer: Color.fromARGB(255, 48, 250, 152),
                      thirdcontentOfcard: 'Active Trainers',
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    const Text(
                      "Personal Trainers",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          fontSize: 32),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(top: 14),
                      width: 60,
                      height: 180,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(12)),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "A trainer",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 28),
                          ),
                          Text(
                            "Personal Trainer",
                            style: TextStyle(
                                color: Color.fromARGB(255, 107, 107, 107),
                                fontSize: 16),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "3",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Clients",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No Data'));
            }
          },
        )),
      ),
    );
  }
}
