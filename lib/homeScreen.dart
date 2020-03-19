//import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:corona/pages/otherPage.dart';
import 'package:corona/pages/mainPage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

//  final List<String> _myEvents = ["Health", "Precautions"];

  int pageIndex = 0;

  //Create all the Pages
  final OtherPage _otherPage = OtherPage();
  final MainPage _mainPage = MainPage();

  Widget _showPage = new MainPage();

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _otherPage;
        break;
      case 1:
        return _otherPage;
        break;
      case 2:
        return _mainPage;
        break;
      case 3:
        return _otherPage;
        break;
      case 4:
        return _otherPage;
        break;
      default:
        return new Container(
          child: new Center(
            child: new Text("No page Found"),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.deepPurple,
        title: new Text('COVID-19'),
      ),
      body: Container(
        color: Colors.black12,
        child: Center(
          child: _showPage,
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(

        backgroundColor: Colors.black12,
        buttonBackgroundColor: Colors.white,
        items: <Widget>[

          Icon(
            Icons.add,
            size: 20,
            color: Colors.deepPurple,
          ),
          Icon(Icons.list, size: 20, color: Colors.deepPurple),
          Icon(Icons.healing, size: 20, color: Colors.deepPurple),
          Icon(Icons.compare_arrows, size: 20, color: Colors.deepPurple),
          Icon(Icons.map, size: 20, color: Colors.deepPurple)
        ],
        index: 2,
        onTap: (index) {
          setState(() {
//            pageIndex = index;
            _showPage = _pageChooser(index);
          });
        },
      ),
    );
  }

}
