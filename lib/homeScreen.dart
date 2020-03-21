//import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:corona/pages/otherPage.dart';
import 'package:corona/pages/mainPage.dart';
import 'package:corona/pages/gMap.dart';

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
  final GMap _gMapPage = GMap();

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
        return _gMapPage;
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
//      appBar: new AppBar(
//        backgroundColor: Colors.transparent,
//        title: new Text('COVID-19'),
//      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: _showPage,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.map),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return GMap();
          }));
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(

        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.blue,
        color: Colors.black12,
        items: <Widget>[

          Icon(
            Icons.add,
            size: 20,
            color: Colors.indigo,
          ),
          Icon(Icons.list, size: 20, color: Colors.indigo),
          Icon(Icons.healing, size: 20, color: Colors.indigo),
          Icon(Icons.compare_arrows, size: 20, color: Colors.indigo),
          Icon(Icons.map, size: 20, color: Colors.indigo)
        ],
        index: 2,
        onTap: (index) {
          setState(() {
//            pageIndex = index;
            if (index != 4) {
              _showPage = _pageChooser(index);
            } else {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return GMap();
              }));
            }
          });
        },
      ), floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

}
