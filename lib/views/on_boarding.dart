import 'package:corona/pages/root_page.dart';
import 'package:corona/services/authentication.dart';
// import 'package:corona/views/login_signup_page.dart';
import 'package:flutter/material.dart';
import 'package:fancy_on_boarding/fancy_on_boarding.dart';

Color primary = Colors.blue.shade800;
const  red = Colors.red;
const Color white = Colors.white;
const Color black = Colors.black;
const Color grey = Colors.grey;
const Color green = Colors.green;



class OnBoarding extends StatelessWidget {
  final pageList = [

    PageModel(
        color: white,
        heroAssetPath: 'images/social.png',
        title: Text('How it works?',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: primary,
              fontSize: 34.0,
            )),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('We keep you safe and healthy by displaying the locations of infected users near you',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: grey,
                fontSize: 18.0,
              )),
        ),
        iconAssetPath: 'images/circle.png'
    ),

    PageModel(
        color: white,
        heroAssetPath: 'images/q.png',
        title: Text('More Info',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: primary,
              fontSize: 34.0,
            )),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('We have got a live tracker page to help you track the number of active COVID-19 cases issued by government of India',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: grey,
                fontSize: 18.0,
              )),
        ),
        iconAssetPath: 'images/circle.png'
    ),
    PageModel(
        color: white,
        heroAssetPath: 'images/care.png',
        title: Text('Healthcare Centre',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: primary,
              fontSize: 34.0,
            )),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Got an emergency and need to contact the government assigned state healthcare centre? We have a one click contact list for your convenience',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: grey,
                fontSize: 18.0,
              )),
        ),
        iconAssetPath: 'images/circle.png'
    ),

    PageModel(
        color: white,
        heroAssetPath: 'images/mobile.png',
        title: Text('Privacy',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: primary,
              fontSize: 34.0,
            )),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('We take permission of an infected user before sharing their location anonymously. So that millions of others can be safe.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: grey,
                fontSize: 18.0,
              )),
        ),
        iconAssetPath: 'images/circle.png'
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FancyOnBoarding(
            doneButtonBackgroundColor: primary,
            doneButtonText: "Done",
            pageList: pageList,
            onDoneButtonPressed: () =>
                // Navigator.pushReplacementNamed(context, "/LogInSignUp"),
                Navigator.push(context, MaterialPageRoute(builder: (context)=>RootPage(auth: new Auth()))),
            onSkipButtonPressed: () =>
                // Navigator.pushReplacementNamed(context, "/LogInSignUp"),
                Navigator.push(context, MaterialPageRoute(builder: (context)=>RootPage(auth: new Auth()))),
          ),
          Positioned.fill(
            bottom: 10,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomText(text: "< swipe left", color: grey.withOpacity(0.5),)),)
        ],
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;
  
  // name constructor that has a positional parameters with the text required
  // and the other parameters optional
  CustomText({@required this.text, this.size,this.color,this.weight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,style: TextStyle(fontSize: size ?? 16, color: color ?? black, fontWeight: weight ?? FontWeight.normal),
    );
  }
}