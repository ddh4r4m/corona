import 'dart:async';
import 'dart:io';
import 'package:location/location.dart' as LocaTion;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:corona/homeScreen.dart';
import 'package:corona/pages/root_page.dart';
import 'package:corona/services/authentication.dart';
// import 'package:corona/views/login_signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
//import 'package:corona/pages/root_page.dart';
//import 'package:corona/services/auth_service.dart';
//import 'package:firebase_database/firebase_database.dart';
//import 'package:corona/widget/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
//import 'dart:async';
//import 'package:corona/services/authentication.dart';


class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}


final List<String> imgList = [
  'https://ichef.bbci.co.uk/news/208/cpsprodpb/931B/production/_111195673_corona_whatyouneedtodo_without_title-nc.png',
  'https://www.cdc.gov/coronavirus/2019-ncov/images/social/covid-19-symptoms-v03.png',
  'https://www.who.int/images/default-source/health-topics/coronavirus/risk-communications/general-public/safe-greetings.tmb-1920v.png?sfvrsn=2e97004e_1',
  'https://www.who.int/images/default-source/health-topics/coronavirus/risk-communications/general-public/handshaking.tmb-1920v.png?sfvrsn=4aed53c5_1',
  'https://www.who.int/images/default-source/health-topics/coronavirus/risk-communications/general-public/wearing-gloves.tmb-1920v.png?sfvrsn=ec69b46a_1',
  'https://www.who.int/images/default-source/health-topics/coronavirus/social-media-squares/be-smart-if-you-develop.tmb-1920v.jpg?sfvrsn=1486258a_6',
  'https://www.who.int/images/default-source/health-topics/coronavirus/social-media-squares/be-smart-inform.tmb-1920v.jpg?sfvrsn=f6dbe358_6',
  'https://www.who.int/images/default-source/health-topics/coronavirus/social-media-squares/be-safe.tmb-1920v.jpg?sfvrsn=1f6e4aef_6',
  'https://www.who.int/images/default-source/health-topics/coronavirus/social-media-squares/be-kind-to-support.tmb-1920v.jpg?sfvrsn=1856f2a3_7',
  'https://www.who.int/images/default-source/health-topics/coronavirus/social-media-squares/be-kind-to-address-stigma.tmb-1920v.jpg?sfvrsn=4615bfbe_6',
  'https://www.who.int/images/default-source/health-topics/coronavirus/social-media-squares/be-kind-to-address-fear.tmb-1920v.jpg?sfvrsn=a8e99f14_6',
  'https://www.who.int/images/default-source/health-topics/coronavirus/risk-communications/general-public/protect-yourself/blue-1.tmb-1920v.png?sfvrsn=3d15aa1c_1',
  'https://www.who.int/images/default-source/health-topics/coronavirus/risk-communications/general-public/protect-yourself/blue-2.tmb-1920v.png?sfvrsn=2bc43de1_1',
  'https://www.who.int/images/default-source/health-topics/coronavirus/risk-communications/general-public/protect-yourself/blue-3.tmb-1920v.png?sfvrsn=b1ef6d45_1',
  'https://www.who.int/images/default-source/health-topics/coronavirus/risk-communications/general-public/protect-yourself/blue-4.tmb-1920v.png?sfvrsn=a5317377_5',
  'https://www.who.int/images/default-source/health-topics/coronavirus/risk-communications/general-public/stay-healthy-while-travelling/1.tmb-1920v.png?sfvrsn=1a813eed_4',
  'https://www.who.int/images/default-source/health-topics/coronavirus/risk-communications/general-public/stay-healthy-while-travelling/2.tmb-1920v.png?sfvrsn=13250c49_4',
  'https://www.who.int/images/default-source/health-topics/coronavirus/risk-communications/general-public/stay-healthy-while-travelling/3.tmb-1920v.png?sfvrsn=5e5a641_4',
  'https://www.who.int/images/default-source/health-topics/coronavirus/risk-communications/general-public/stay-healthy-while-travelling/4.tmb-1920v.png?sfvrsn=9719c641_4'
];



class _MainPageState extends State<MainPage> {

//
//  @override
//  void initState() {
//    super.initState();
//    widget.auth.getCurrentUser().then((user) {
//      setState(() {
//        if (user != null) {
//          _userId = user?.uid;
//        }
//        authStatus =
//        user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
//      });
//    });
//  }

//  signOut() async {
//    try {
//      await widget.auth.signOut();
//      widget.logoutCallback();
//    } catch (e) {
//      print(e);
//    }
//  }
//
  bool victimOrNot = false;
  StreamSubscription _locationSubscription;
  LocaTion.Location _locationTracker = LocaTion.Location();

  void startServiceInPlatform() async {
    if (Platform.isAndroid) {
      var methodChannel = MethodChannel("com.example.corona");
      String data = await methodChannel.invokeMethod("startService");
      debugPrint(data);
    }
  }

  @override
  void initState() {
    // implement initState
    super.initState();
    startServiceInPlatform();
    getCurrentLocation();
    }

  CarouselSlider getFullScreenCarousel(BuildContext mediaContext) {
    return CarouselSlider(
      autoPlay: true,
      viewportFraction: 1.0,
      aspectRatio: 2,
      items: imgList.map(
            (url) {
          return Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
              child: Image.network(
                url,
                fit: BoxFit.cover,
                width: 1000.0,
              ),
            ),
          );
        },
      ).toList(),
    );
  }

//  final List<String> _myEvents = ["Health", "Precautions"];

  final CarouselSlider autoPlayDemo = CarouselSlider(
    viewportFraction: 0.9,
    aspectRatio: 2.0,
    autoPlay: true,
    enlargeCenterPage: true,
    autoPlayCurve: Curves.fastOutSlowIn,
    pauseAutoPlayOnTouch: Duration(seconds: 2),
    items: imgList.map(
          (url) {
        return Container(
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4.0, // soften the shadow
                spreadRadius: 0.5, //extend the shadow
                offset: Offset(
                  2.0, // Move to right 10  horizontally
                  3.0, // Move to bottom 10 Vertically
                ),
              )
            ],
              color: Colors.blueAccent,
                  borderRadius:  BorderRadius.all(Radius.circular(8.0)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            child: Image.network(
              url,
              fit: BoxFit.cover,
              width: 1000.0,
            ),
          ),
        );
      },
    ).toList(),
  );



  void getCurrentLocation() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentReference userData = await Firestore.instance.collection("Users").document(user.uid.toString());
    userData.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        if (datasnapshot.data["victim"] != null) {
          victimOrNot = datasnapshot.data["victim"];
        }
      } else {
        print("No such user");
      }
    });
    // QuerySnapshot homeLocn = await Firestore.instance.collection("Users").getDocuments();
    try {
      // var location = await _locationTracker.getLocation();
      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }
      _locationSubscription =
          _locationTracker.onLocationChanged().listen((newLocalData) {
            if (victimOrNot) {
              Firestore.instance.collection('Markers').document(user.uid).updateData({
                "location": GeoPoint(newLocalData.latitude, newLocalData.longitude),
                "time": DateTime.now(),
                "userid": user.uid,
                "victim":victimOrNot
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



//   Future<void> getMyUser() async {
//     FirebaseUser user = await FirebaseAuth.instance.currentUser();
//     print(user.email);
//     addHomeLocation(user.uid);
// //    return user;
//   }

//   Future<void> addHomeLocation(String uid) async {
//     final position = await Geolocator()
//         .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//     //This Update Method needs to be more secure
//     Firestore.instance.collection('Users').document(uid).updateData({
//       "location": GeoPoint(position.latitude, position.longitude)
//     }).catchError((e) {
//       print(e);
//     });
//     Firestore.instance.collection('Markers').document(uid).setData({
//       "location": GeoPoint(position.latitude, position.longitude),
//       "time": DateTime.now(),
//       "userid": uid,
//     });
//   }


  Future<void> signOut() async {
    //create an instance you your firebase auth.
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    //return this future to the place you called it.
    return _firebaseAuth.signOut().whenComplete(() {
      Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation,
              Animation secondaryAnimation) {
            return RootPage(auth: new Auth());
          }, transitionsBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation, Widget child) {
            return new SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          }),
              (Route route) => false);
//      Navigator.pop(context);
//      Navigator.of(context).pushReplacementNamed('/LogInSignUp');
//      Navigator.popUntil(context, ModalRoute.withName('/LogInSignUp'));
      print("SignOut Done");
    }).catchError((error) {
      print("error in signout $error");
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          color: Colors.white,
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          padding: EdgeInsets.only(top: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Welcome', style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 42),
                              textAlign: TextAlign.start),
                        ),
                        Align(

                          alignment: Alignment.topRight,
                          child: new RaisedButton(
                            color: Colors.blue,
                            onPressed: signOut,
                            child: new Text('Logout',
                                style: new TextStyle(fontSize: 17.0, color: Colors.white)),
                          ),
                        ),

                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(" Let's begin...", style: TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 12),
                          textAlign: TextAlign.start),
                    ),

//                    Align(
//                      alignment: Alignment.centerRight,
//                      child: IconButton(
//                        icon: Icon(Icons.undo),
//                        onPressed: () async{
//                          try{
//                            AuthService auth = Provider.of(context).auth;
//                            await auth.signOut().then((_){
//                              Navigator.of(context).pushNamedAndRemoveUntil("/LogIn", ModalRoute.withName("/HomeScreen"));
//                            });
//                            print("Signed Out");
//                          }catch(e){
//                            print(e);
//                          }
//                        },
//                      ),
//                    )
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.0),
                  child: Column(children: [
                    autoPlayDemo,
                  ])),
              Expanded(
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 0.0),
                  children: <Widget>[
                    _buildCard("FAQs", 20, 25,Icons.question_answer,"/faqPage"),
                    _buildCard("Current Status", 20, 25,Icons.speaker_notes,"/newsPage"),
//                      _buildCard("Symptoms",0,51),
//                      _buildCard("More..",0,51)
                  ],
                ),
              )
            ],
          ),
        ));
  }
//  String iconName = "save";
  Widget _buildCard(String name, double topPad, double bottomPad, IconData iconName, String pageName) {
    return Padding(
      padding:
      EdgeInsets.only(top: topPad, bottom: bottomPad, left: 5, right: 5),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, pageName);
//          Navigator.of(context).pushReplacementNamed(pageName);
        },
        child: Container(
//          width: 60,
//          height: 130,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.blue,
                blurRadius: 15.0, // soften the shadow
                spreadRadius: 1.0, //extend the shadow
                offset: Offset(
                  3.0, // Move to right 10  horizontally
                  3.0, // Move to bottom 10 Vertically
                ),
              )
            ],
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.red,
            gradient: new LinearGradient(
                colors: [Colors.deepPurple, Colors.cyan],
                begin: Alignment.centerRight,
                end: new Alignment(-1.0, -1.0)),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 34.0,
                      child: Icon(
                        iconName,
                        size: 40,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.white.withOpacity(0.2),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      name,
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

