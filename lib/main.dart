import 'dart:async';
import 'package:corona/pages/faqPage.dart';
import 'package:corona/pages/otherPage.dart';
import 'package:corona/views/login_signup_page.dart';
//import 'package:corona/widget/provider_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:corona/homeScreen.dart';
import 'package:corona/views/LoginScreen.dart';
import 'package:corona/views/SignUpScreen.dart';
//import 'package:corona/services/auth_service.dart';
import 'package:corona/services/authentication.dart';
import 'package:corona/pages/root_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
            debugShowCheckedModeBanner: false,
            home: new RootPage(auth: new Auth()),
            routes: <String, WidgetBuilder>{
//            '/SignUp': (BuildContext context) => new SignUpScreen(),
//            '/LogIn': (BuildContext context) => new LoginScreen(),
              '/LogInSignUp': (BuildContext context) => new LoginSignupPage(),
              '/HomeScreen': (BuildContext context) => new HomeScreen(),
              '/faqPage': (BuildContext context) => new faqPage(),
              '/newsPage': (BuildContext context) => new OtherPage(),
          },
        );
  }
}
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<FirebaseUser> getUser() async{
  return await _auth.currentUser();
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
//    HomeController();
//    if (FirebaseAuth.instance.currentUser() != null) {
//      Navigator.of(context).pushReplacementNamed('/HomeScreen');
//      print(FirebaseAuth.instance.currentUser());
//      print('data');
//    } else {
//      Navigator.of(context).pushReplacementNamed('/LogIn');
//    }
    getUser().then((user){
      if(user!=null){
        Navigator.of(context).pushReplacementNamed('/HomeScreen');
        print(user);
        //show the Page
      }else{
        Navigator.of(context).pushReplacementNamed('/LogIn');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTime();
    getUser().then((user){
      if(user!=null){
        Navigator.of(context).pushReplacementNamed('/HomeScreen');
        print(user);
       //show the Page
      }else{
        Navigator.of(context).pushReplacementNamed('/LoginScreen');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(child: new Image.asset('images/corona.png')),
                            Center(
                              child: Text(
                                'COVID-19',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
//        decoration: BoxDecoration(color: Colors.white),
//        child: Column(
//          children: <Widget>[
//
//
//          ],
//        ),
      ),
//      body: new Center(
//        child: new Image.asset('images/corona.png'),
//      ),
    );
  }
}
//
//class HomeController extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    final AuthService auth = Provider.of(context).auth;
//    return StreamBuilder<String>(
//      stream: auth.onAuthStateChanged,
//      builder: (context, AsyncSnapshot<String> snapshot) {
//        if (snapshot.connectionState == ConnectionState.active) {
//          final bool signedIn = snapshot.hasData;
//          return signedIn ? HomeScreen() : LoginScreen();
//        }
//        return CircularProgressIndicator();
//      },
//    );
//  }
//}
