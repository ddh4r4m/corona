import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:corona/homeScreen.dart';
//void main() => runApp(GMap());

class GMap extends StatefulWidget {
//  @override
//  _GMapState() => _GMapState();

  @override
  State<StatefulWidget> createState() {
  
    return _GMapState();
  }
}

class _GMapState extends State<GMap> {
  Set<Marker> _markers = HashSet<Marker>();
  Set<Circle> _circles = HashSet<Circle>();
  Set<Polygon> _polygons = HashSet<Polygon>();
  GoogleMapController mapController;
  BitmapDescriptor _markerIcon;

  @override
  void initState() {
    // implement initState
    super.initState();
    _setCircles();
  }

//  void _setMarkerIcon() async{
//    _markerIcon = await BitmapDescriptor.fr
//  }
  final LatLng _center = const LatLng(28.7041, 77.1025);
  void _setCircles(){
    _circles.add(Circle(
        circleId: CircleId("0"),
      center: _center,
      radius: 1000,
      strokeWidth: 0,
      fillColor: Color.fromRGBO(245, 105, 66, 0.5)
    ));
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    setState(() {
      _markers.add(
        Marker(
          //Fetch this from api make sure unique
          markerId: MarkerId('0'),
          position:  _center,
          infoWindow: InfoWindow(title: 'Delhi',snippet: 'Testing app here')

        )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          moveToLastScreen();
        },
        child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: Text('Victim History'),
              backgroundColor: Colors.blue[700],
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  moveToLastScreen();
                },
              ),
            ),
            body: Stack(
              children: <Widget>[
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 11.0,
                  ),
                  markers: _markers,
                  circles: _circles,
                ),
                Container(
                  alignment: Alignment.bottomCenter
                  ,padding: EdgeInsets.fromLTRB(0, 0, 0, 32),
                  child: Text("Victims Around the Globe"),
                )
              ],
            ),
          ),
        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context);
    return null;
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return HomeScreen();
    // })
    // );
  }
}
