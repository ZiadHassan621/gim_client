import 'package:flutter/material.dart';
import 'package:gim_client/Pages/dasboard.dart';

class MultiPagesNav extends StatefulWidget {
  const MultiPagesNav({super.key});

  @override
  State<MultiPagesNav> createState() => _MultiPagesNavState();
}

class _MultiPagesNavState extends State<MultiPagesNav> {
  int _selectedindex = 0;
  bool isLoading = true;

  List<Widget> pages = const <Widget>[
    DashBoard(),
    Center(child: Icon(Icons.home)),
    Center(child: Icon(Icons.settings))
  ];

  void selectIndex(int currentindex) {
    setState(() {
      _selectedindex = currentindex;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(
      Duration(seconds: 4),
      () {
        setState(() {
          isLoading = false;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 0, 0, 255),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : pages[_selectedindex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Person")
        ],
        elevation: 0,
        currentIndex: _selectedindex,
        backgroundColor: const Color.fromARGB(0, 0, 0, 255),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[700],
        onTap: selectIndex,
      ),
    );
  }
}
