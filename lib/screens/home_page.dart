import 'package:tamadun/screens/favpage.dart';
import 'package:tamadun/screens/searchpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'more_page.dart';
import 'mainpage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  List <Widget> _screen =[
    MainPage(),SearchPage(),FavScreenTwo(), Morepage(isGmail: false,),
  ];
  int _selectedIndex = 0;
  void _onPageChanged(int index) {
    if (index != 1) {
      setState(() {
        _selectedIndex = index;
      });

      print(_selectedIndex);
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => SearchPage()),
      );
    }

  }
  void _onItemTapped(int selectedIndex){
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screen,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: Container(
        height: 65,

        decoration: BoxDecoration(

            borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight:Radius.circular(30),
            ),boxShadow:[BoxShadow(color:Colors.grey,spreadRadius:1,blurRadius:20)]),
        child:ClipRRect(
          borderRadius: BorderRadius.only(topLeft:Radius.circular(30.0),topRight:Radius.circular(30.0),
          ),

          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black54,
            iconSize: 29,
            showSelectedLabels: false,
            showUnselectedLabels:false,

            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home,
                color: _selectedIndex==0 ? Colors.black: Colors.grey,),
                label: '',),
              BottomNavigationBarItem(icon: Icon(Icons.search,
                color: _selectedIndex==1 ? Colors.black: Colors.grey,),
                label: '',),
              BottomNavigationBarItem(icon: Icon(Icons.bookmark_border,
                color: _selectedIndex==2 ? Colors.black: Colors.grey,),
                label: '',),
              BottomNavigationBarItem(icon: Icon(Icons.menu,
                color: _selectedIndex==3 ? Colors.black: Colors.grey,),
                label: '',),
            ],
          ),
        ),
      ),
    );
  }

  void share(BuildContext context){
    String message = 'Check out this useful content!';
    RenderBox? box = context.findRenderObject() as RenderBox;

    Share.share(message, subject: 'Desription',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}

