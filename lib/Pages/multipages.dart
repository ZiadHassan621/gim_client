import 'package:flutter/material.dart';
import 'package:gim_client/Pages/dasboard.dart';

class MultiPagesNav extends StatefulWidget {
  MultiPagesNav({super.key, this.id});
  int? id;

  @override
  State<MultiPagesNav> createState() => _MultiPagesNavState();
}

class _MultiPagesNavState extends State<MultiPagesNav> {
  int _selectedindex = 0;
  bool isLoading = true;
  late List<Widget> pages;
  @override
  void initState() {
    pages = [
      DashBoard(
        id: widget.id,
      ),
      const Center(child: Icon(Icons.home)),
      const Center(child: Icon(Icons.settings)),
    ];
    // TODO: implement initState
   
    super.initState();
  }

  

  void selectIndex(int currentindex) {
    setState(() {
      _selectedindex = currentindex;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 0, 0, 255),
      body: pages[_selectedindex],
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
