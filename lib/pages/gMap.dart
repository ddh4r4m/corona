import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:corona/homeScreen.dart';
//void main() => runApp(GMap());

class GMap extends StatefulWidget {
//  @override
//  _GMapState() => _GMapState();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GMapState();
  }
}

class _GMapState extends State<GMap> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(28.7041, 77.1025);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
            body: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
          ),
        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomeScreen();
    }));
  }
}
