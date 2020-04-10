import 'dart:async';
import 'dart:math' show cos, sqrt, asin;
import 'dart:collection';
import 'package:corona/pages/profilePage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:latlong/latlong.dart' as DistCal;
import 'package:location/location.dart' as LocaTion;

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
  StreamSubscription _locationSubscription;
  LocaTion.Location _locationTracker = LocaTion.Location();
  Stream<QuerySnapshot> _myMarkers;
  Set<Marker> _markers = Set<Marker>();
  Set<Circle> _circles = Set<Circle>();
  List<Marker> allMarkers = [];

  setMarkers(){
    return allMarkers;
  }

  bool victimOrNot = false;

  void getCurrentLocation() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentReference userData = await Firestore.instance
        .collection("Users")
        .document(user.uid.toString());
    userData.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        if (datasnapshot.data["victim"] != null) {
          victimOrNot = datasnapshot.data["victim"];
          print(datasnapshot.data['victim'].toString());
          print('jk');
          print(victimOrNot);
        }
      } else {
        print("No such user");
      }
    });
    QuerySnapshot homeLocn =
    await Firestore.instance.collection("Users").getDocuments();
    homeLocn.documents.forEach((f) => print(f["name"]));
    print("end");
    try {
//      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

//      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

//      _locationTracker.changeSettings(
//          accuracy: LocaTion.LocationAccuracy.HIGH,
//          interval: 5000,
//          distanceFilter: 5);
      _locationSubscription =
          _locationTracker.onLocationChanged().listen((newLocalData) {
//        if (_controller != null) {
//          _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
//              bearing: 192.8334901395799,
//              target: LatLng(newLocalData.latitude, newLocalData.longitude),
//              tilt: 0,
//              zoom: 18.00)));
//          updateMarkerAndCircle(newLocalData, imageData);
//        }
            print('thisdata');
            print(location);
            print(calculateDistance(location.latitude, location.longitude,
                newLocalData.latitude, newLocalData.longitude));
            if (victimOrNot) {

          setState(() {
            _markers.removeWhere((m)=>m.markerId.value == uid.toString());
            _circles.removeWhere((m)=>m.circleId.value == uid.toString());
            Firestore.instance.collection('Markers').document(user.uid).delete();
//            _markers.remove(_markers.firstWhere((Marker marker) => marker.markerId.value == user.uid));
//            _markers = _markers;

          });
//          Firestore.instance.collection('Markers').document(user.uid).delete();
              print(_markers.length);
              print(_markers);
//          mapController.
//          _markers.remove(_markers.firstWhere((Marker marker) => marker.markerId.value == user.uid));
//          _markers.removeAll();
              print(_markers.length);
              print(_markers);
//          print(_markers);

              Firestore.instance.collection('Markers').document(user.uid).setData({
                "location": GeoPoint(newLocalData.latitude, newLocalData.longitude),
//            "time": DateTime.now(),
                "userid": user.uid,
                "victim": victimOrNot
              });
            }
            print(newLocalData);
          });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }


//  Set<Polygon> _polygons = HashSet<Polygon>();
  GoogleMapController mapController;

  var clients = [];
  var currentLocation;

  bool mapToggle = false;
  bool clientsToggle = false;

  @override
  void dispose() {
    super.dispose();
  }


  @override
  void initState() {
    // implement initState
    super.initState();
    _setCircles();
    _myMarkers = Firestore.instance.collection('markers').snapshots();
//    print(_myMarkers);
    Geolocator().getCurrentPosition().then((currloc) {
//      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//        target: LatLng(currloc.latitude,currloc.longitude),
//        zoom: 14,
//        bearing: 90,
//        tilt: 45
//      )));
      setState(() {
        _center = LatLng(currloc.latitude, currloc.longitude);
        currentLocation = currloc;
        mapToggle = true;
        populateClients();
      });
    });
  }

  _addMarker(){
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId("newma"),
        icon: BitmapDescriptor.defaultMarkerWithHue(_pinkHue),
        position: LatLng(28.9041, 77.1025),
//                  infoWindow: InfoWindow(
//                    title: snapshot.data.documents[i]['name'],
//                    snippet: snapshot.data.documents[i]['address'],
//                  )
      )
      );
    });
  }

  _deleteMarker(){
    setState(() {
      _markers.removeWhere((m)=>m.markerId.value == 'newma');
//      Firestore.instance.collection('Markers').document(uid).delete();
//      _markers = _markers;

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
  static LatLng _center = const LatLng(28.8041, 77.1025);

  void _setCircles() {
    _circles.add(Circle(
        circleId: CircleId("0"),
        center: _center,
        radius: 1000,
        strokeWidth: 0,
        fillColor: Color.fromRGBO(245, 105, 66, 0.5)));
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
//      _markers.add(
//        Marker(
//          //Fetch this from api make sure unique
//          markerId: MarkerId('0'),
//          position:  _center,
//          infoWindow: InfoWindow(title: 'Delhi',snippet: 'Testing app here')
//
//        )
//      );
    });
  }

  Future<void> getMyUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print(user.email);
    addHomeLocation(user.uid);
    return user;
  }

  Future<void> addHomeLocation(String uid) async {
    final position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    //This Update Method needs to be more secure
    Firestore.instance.collection('Users').document(uid).updateData({
      "location": GeoPoint(position.latitude, position.longitude)
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> addMyLocation(String email) async {
    final position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    //This Update Method needs to be more secure
    Firestore.instance.collection('markers').add({
      "address": "New Address",
      "date": DateTime.now(),
      "location": GeoPoint(position.latitude, position.longitude),
      "name": "D",
      "placeId": "DDDff2"
    }).catchError((e) {
      print(e);
    });
  }

  DistCal.Distance distance = DistCal.Distance();

  double calculateDistance(lat1, lon1, lat2, lon2) {
    double totalDistanceInM = 0;
    totalDistanceInM =
        distance(DistCal.LatLng(lat1, lon1), DistCal.LatLng(lat2, lon2));
    return totalDistanceInM;
//      var p = 0.017453292519943295;
//      var c = cos;
//      var a = 0.5 - c((lat2 - lat1) * p)/2 +
//          c(lat1 * p) * c(lat2 * p) *
//              (1 - c((lon2 - lon1) * p))/2;
//      return 12742 * asin(sqrt(a));
  }

  void _getCurrentLocation() async {
    //it'll contain both latitudes and longitudes
    final position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14,
        bearing: 90,
        tilt: 45)));
    print(position);
//    getMyUser();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
//    print(user.email);
//    addMyLocation(user.email);
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
              stream: Firestore.instance.collection('Markers').snapshots(),
              //_myMarkers,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (!snapshot.hasData) {
                  return Center(
                    child: const Text('Loading...Bro'),
                  );
                }
//                return victimsMap(documents: snapshot.data.documents,);
                return Column(
                  children: <Widget>[
                    Flexible(
                        flex: 1,
                        child: loadMap()
//                        GoogleMap(
//                          onMapCreated: _onMapCreated,
//                          initialCameraPosition: CameraPosition(
//                            target: _center,
//                            zoom: 11.0,
//                          ),
//                          markers: snapshot.data.documents
//                              .map((document) =>
////          DateTime.now().difference(document["time"]).inMinutes >5
//                                  true
//                                      ? Marker(
//                                          markerId:
//                                              MarkerId(document['userid']),
//                                          icon: BitmapDescriptor
//                                              .defaultMarkerWithHue(_pinkHue),
//                                          position: LatLng(
//                                            document['location'].latitude,
//                                            document['location'].longitude,
//                                          ),
//                                          infoWindow: InfoWindow(
//                                            title: document['name'],
//                                            snippet: document['address'],
//                                          ))
//                                      : Marker(
//                                          markerId:
//                                              MarkerId(document["userid"])))
//                              .toSet(),
//                          circles: snapshot.data.documents
//                              .map((document) => Circle(
//                                  circleId: CircleId(document['userid']),
//                                  center: LatLng(document['location'].latitude,
//                                      document['location'].longitude),
//                                  radius: 100,
//                                  strokeWidth: 0,
//                                  fillColor: Color.fromRGBO(0, 189, 50, 0.4)))
//                              .toSet(),
//                        )
//                    victimsMap(
//                        documents: snapshot.data.documents,
//                        initialPosition: _center,
//                      ),
                    )
//                    ,new FlatButton(onPressed:(){_deleteMarker();} , child: Text("Delete"))
//                    ,new FlatButton(onPressed:(){_addMarker();} , child: Text("Add"))

                  ],
                );
                final mapData = snapshot.data.documents;
              },
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.location_searching),
              onPressed: () {
//                _getCurrentLocation();
                getCurrentLocation();
//                getMyUser();
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



  Widget loadMap(){
    return StreamBuilder(
      stream: Firestore.instance.collection("Markers").snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData) return Text('Loading Maps....Please Wait...');
        _markers.clear(); //remove all the markers
        _circles.clear();
        for(int i=0;i<snapshot.data.documents.length;i++){
          _markers.add(Marker(
                  markerId: MarkerId(snapshot.data.documents[i]['userid']),
                  icon: BitmapDescriptor.defaultMarkerWithHue(_pinkHue),
                  position: LatLng(
                    snapshot.data.documents[i]['location'].latitude,
                    snapshot.data.documents[i]['location'].longitude,
                  ),
//                  infoWindow: InfoWindow(
//                    title: snapshot.data.documents[i]['name'],
//                    snippet: snapshot.data.documents[i]['address'],
//                  )
                  )
          );
          _circles.add(Circle(
              circleId: CircleId(snapshot.data.documents[i]['userid']),
              center: LatLng(snapshot.data.documents[i]['location'].latitude,
                  snapshot.data.documents[i]['location'].longitude),
              radius: 400,
              strokeWidth: 0,
              fillColor: Color.fromRGBO(255, 94,10, 0.3)));
        }
        return GoogleMap(
          markers: _markers,
          circles: _circles,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        );
      },
    );
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
      markers: documents
          .map((document) =>
//          DateTime.now().difference(document["time"]).inMinutes >5
      true
          ? Marker(
          markerId: MarkerId(document['userid']),
          icon: BitmapDescriptor.defaultMarkerWithHue(_pinkHue),
          position: LatLng(
            document['location'].latitude,
            document['location'].longitude,
          ),
          infoWindow: InfoWindow(
            title: document['name'],
            snippet: document['address'],
          ))
          : Marker(markerId: MarkerId(document["userid"])))
          .toSet(),
      circles: documents
          .map((document) => Circle(
          circleId: CircleId(document['userid']),
          center: LatLng(document['location'].latitude,
              document['location'].longitude),
          radius: 1000,
          strokeWidth: 0,
          fillColor: Color.fromRGBO(255, 94,10, 0.4)))
          .toSet(),
    );
  }
}
