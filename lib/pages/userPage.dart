import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String userName = '  ';
  bool _victim = false;

  @override
  void initState() {
    // implement initState
    super.initState();
    getCurrentUser();
  }


  Future<void> getMyUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print(user.email);
    addHomeLocation(user.uid);
//    return user;
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
    Firestore.instance.collection('Markers').document(uid).setData({
      "location": GeoPoint(position.latitude, position.longitude),
      "time": DateTime.now(),
      "userid": uid,
    });
  }


  getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentReference userData = await Firestore.instance
        .collection("Users")
        .document(user.uid.toString());
//    return userData;
    userData.get().then((datasnapshot) {
      if (datasnapshot.exists) {
//        return datasnapshot;
        if (datasnapshot.data["name"] != null) {
          setState(() {
            userName = datasnapshot.data["name"];
            _victim = datasnapshot.data["victim"];
          });
        }
      }
    });
//    return userData;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 60),
        CircleAvatar(
          minRadius: 50,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          child: Text(
            userName[0],
            style: TextStyle(fontSize: 30),
          ),
        ),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.center,
          child: userName != ""
              ? Text('Hey!! ' + userName,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 42,
                      color: Colors.lightBlue),
                  textAlign: TextAlign.start)
              : Text("Loading..."),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
          children: <Widget>[
            new Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                child: new Text(
                  'Are You affected by Covid-19',
                  style: TextStyle(color: _victim?Colors.red:Colors.green),
                )),
            new Switch(
              activeColor: Colors.red,
                inactiveTrackColor: Colors.green,
                value: _victim,
                onChanged: (value) {
                  setState(() {
                    _victim = value;
                  });
                })
          ],
        ),
        Center(
          child: RaisedButton(
            color: Colors.blue[400],
              splashColor: Colors.lightBlueAccent,
              child: Text("Add Home Location", style: TextStyle(color: Colors.blue[900]),),
              onPressed: () {
                getMyUser();
              }

          ),
        )
      ],
    );
  }
}
