import 'dart:collection';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  Stream<QuerySnapshot> _myMarkers;
  Set<Marker> _markers = HashSet<Marker>();
  Set<Circle> _circles = HashSet<Circle>();
//  Set<Polygon> _polygons = HashSet<Polygon>();
  GoogleMapController mapController;
//  BitmapDescriptor _markerIcon;

  var clients = [];
  var currentLocation;


  bool mapToggle = false;
  bool clientsToggle = false;


  @override
  void initState() {
    // implement initState
    super.initState();
    _setCircles();
    _myMarkers = Firestore.instance.collection('markers').snapshots();
    print(_myMarkers);
    Geolocator().getCurrentPosition().then((currloc) {
      setState(() {
        currentLocation = currloc;
        mapToggle = true;
        populateClients();
      });
    });
  }

  populateClients() {
    clients = [];
    Firestore.instance.collection('markers').getDocuments().then((docs) {
      if (docs.documents.isNotEmpty) {
        setState(() {
          clientsToggle = true;
        });
        for (int i = 0; i < docs.documents.length; ++i) {
          clients.add(docs.documents[i].data);
//          initMarker(docs.documents[i].data);
        }
      }
    });
  }
//
//  initMarker(client) {
//    mapController.clearMarkers().then((val) {
//      mapController.addMarker(MarkerOptions(
//          position:
//          LatLng(client['location'].latitude, client['location'].longitude),
//          draggable: false,
//          infoWindowText: InfoWindowText(client['clientName'], 'Nice')));
//    });
//  }

//  void _setMarkerIcon() async{
//    _markerIcon = await BitmapDescriptor.fr
//  }
  final LatLng _center = const LatLng(28.8041, 77.1025);
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
    setState(() {
      mapController = controller;
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

  Future<void> getMyUser() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print(user.email);
  }

  Future<void> addMyLocation(String email) async{
    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    //This Update Method needs to be more secure
    Firestore.instance.collection('markers').add({"address":"New Address","date":DateTime.now(),"location":GeoPoint(position.latitude,position.longitude),"name":"D","placeId":"DDDff2"}).catchError((e){
      print(e);
    });
  }

  void _getCurrentLocation() async{
    //it'll contain both latitudes and longitudes
    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
//    getMyUser();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
//    print(user.email);
    addMyLocation(user.email);
//    return position;
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
              title: Text('Affected People'),
              backgroundColor: Colors.blue[700],
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  moveToLastScreen();
                },
              ),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('markers').snapshots(),//_myMarkers,
              builder: (context, snapshot){
                if(snapshot.hasError){
                  return Center(child: Text('Error: ${snapshot.error}'),);
                }
                if(!snapshot.hasData){
                  return Center(child: const Text('Loading...Bro'),);
                }
//                return victimsMap(documents: snapshot.data.documents,);
                return Column(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: victimsMap(
                        documents: snapshot.data.documents,
                        initialPosition: _center,
                      ),
                    )
                  ],

                );
                final mapData = snapshot.data.documents;
              },
            ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.location_searching),
                onPressed: (){
                _getCurrentLocation();
              },
            ),

            //Stack(
//              children: <Widget>[
//                GoogleMap(
//                  onMapCreated: _onMapCreated,
//                  initialCameraPosition: CameraPosition(
//                    target: _center,
//                    zoom: 11.0,
//
//                  ),
//                  markers: _markers,
//                  circles: _circles,
//                ),
//                Container(
//                  alignment: Alignment.bottomCenter
//                  ,padding: EdgeInsets.fromLTRB(0, 0, 0, 32),
//                  child: Text("Victims Around the Globe"),
//                ),
//
//              ],
//            ),
//            floatingActionButton: FloatingActionButton(
//              child: Icon(Icons.location_searching),
//              onPressed: (){
//                _getCurrentLocation();
//              },
//            ),
          ),
        ));
  }

//  _addMarker() {
//    var marker = Marker(
//        position: mapController.cameraPosition.target,
//        icon: BitmapDescriptor.defaultMarker,
//        infoWindowText: InfoWindowText('Magic Marker', '🍄🍄🍄')
//    );
//
//    mapController.addMarker(marker);
//  }
  void moveToLastScreen() {
    Navigator.pop(context);
    return null;
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return HomeScreen();
    // })
    // );
  }
}
const _pinkHue = 220.0;
class victimsMap extends StatelessWidget {

  const victimsMap({
    Key key,
    @required this.documents,
    @required this.initialPosition,
}) : super(key: key);

  final List<DocumentSnapshot> documents;
  final LatLng initialPosition;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
//      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: initialPosition,
        zoom: 11.0,

      ),
      markers: documents.map((document)=>Marker(
        markerId: MarkerId(document['placeId']),
        icon: BitmapDescriptor.defaultMarkerWithHue(_pinkHue),
        position: LatLng(
          document['location'].latitude,
          document['location'].longitude,
        ),
        infoWindow: InfoWindow(
          title: document['name'],
          snippet: document['address'],
        )
      )).toSet(),
      circles: documents.map((document)=>Circle(
          circleId: CircleId(document['placeId']),
          center: LatLng(document['location'].latitude,
            document['location'].longitude),
          radius: 1000,
          strokeWidth: 0,
          fillColor: Color.fromRGBO(255, 94, 0, 0.5)
      )).toSet(),
    );
  }
}
