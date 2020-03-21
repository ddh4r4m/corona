import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  final LatLng _center = const LatLng(45.521563, -122.677433);

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
              title: Text('Maps Sample App'),
              backgroundColor: Colors.green[700],
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
  }
}
