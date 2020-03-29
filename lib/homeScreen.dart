//import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:corona/pages/otherPage.dart';
import 'package:corona/pages/mainPage.dart';
import 'package:corona/pages/gMap.dart';
import 'package:corona/pages/faqPage.dart';
import 'package:corona/pages/newgMap.dart';
import 'package:corona/services/authentication.dart';
import 'package:corona/pages/profilePage.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

//  final List<String> _myEvents = ["Health", "Precautions"];

  int pageIndex = 0;

  //Create all the Pages
  final OtherPage _otherPage = OtherPage();
  final MainPage _mainPage = MainPage();
  final faqPage _faqPage = faqPage();
   final NewGMapPage _gMapPage = NewGMapPage();
  final ProfilePage _profilePage = ProfilePage();

  Widget _showPage = new MainPage();


  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _profilePage;
        break;
      case 1:
        return _faqPage;
        break;
      case 2:
        return _mainPage;
        break;
      case 3:
        return _otherPage;
        break;
      case 4:
        return GMap();
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
            Icons.account_circle,
            size: 20,
            color: Colors.indigo,
          ),
          Icon(Icons.question_answer, size: 20, color: Colors.indigo,),
          Icon(Icons.home, size: 20, color: Colors.indigo),
          Icon(Icons.playlist_add_check, size: 20, color: Colors.indigo),
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
      ), floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

}
