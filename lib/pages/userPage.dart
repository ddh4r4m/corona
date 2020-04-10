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
  String _name = "";
  final _formKey = new GlobalKey<FormState>();
  final TextEditingController _firstNameTextController =
      new TextEditingController();
  bool _victim = false;
  String _errorMessage;
  bool _isLoginForm;
  bool _isLoading = false;

  @override
  void initState() {
    // implement initState
    super.initState();
    getCurrentUser();
  }

  String _validateFields(String text) {
    if (text.length == 0) {
      return "Should not be empty";
    } else {
      return null;
    }
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      String userId = "";
      try {
        FirebaseUser user = await FirebaseAuth.instance.currentUser();
        Firestore.instance.collection('Users').document(user.uid).updateData({
          "name": _name,
          "victim": _victim,
//          "DateCreated": new DateTime.now()
        });
        setState(() {
          _isLoading = false;
          userName = _name;
        });
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
        });
      }
    }
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
    return SingleChildScrollView(
      child: Column(
      children: <Widget>[
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
                  style: TextStyle(color: _victim ? Colors.red : Colors.green),
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
        new Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[showNameInput(), _showCircularProgress()],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                  color: Colors.blue[400],
                  splashColor: Colors.lightBlueAccent,
                  child: Text(
                    "Add Home Location",
                    style: TextStyle(color: Colors.blue[900]),
                  ),
                  onPressed: () {
                    getMyUser();
                  }),
            )
            ,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                  color: Colors.blue[400],
                  splashColor: Colors.lightBlueAccent,
                  child: Text(
                    "Change Data",
                    style: TextStyle(color: Colors.blue[900]),
                  ),
                  onPressed: () {
                    validateAndSubmit();
                  }),
            )
          ],

        ),

      ],
    ));
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget showNameInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 35.0, 0.0),
      child: new TextFormField(
          maxLines: 1,
          controller: _firstNameTextController,
          validator: _validateFields,
          onSaved: (value) => _name = value,
          decoration: InputDecoration(
            icon: new Icon(
              Icons.person,
              color: Colors.blue,
            ),
            labelText: "Name*",
            hintText: "Enter your name",
          )),
    );
  }
}
