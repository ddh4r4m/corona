import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.red,
        title: new Text('HomeScreen'),
      ),
      body: Container(
        color: Colors.black12,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Welcome Home"
            )
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(

        backgroundColor: Colors.black12,
        buttonBackgroundColor: Colors.white,
        items: <Widget>[
          Icon(Icons.add, size:20, color: Colors.red,),
          Icon(Icons.list, size: 20, color: Colors.red),
          Icon(Icons.healing, size: 20, color: Colors.red),
          Icon(Icons.compare_arrows, size: 20, color: Colors.red),
          Icon(Icons.map, size: 20, color: Colors.red)
        ],
        index: 2,
      ),
    );
  }
}