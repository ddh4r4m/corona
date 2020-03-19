import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
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

//  final List<String> _myEvents = ["Health", "Precautions"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      color: Colors.black12,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CarouselSlider(
            enableInfiniteScroll: true,
            autoPlay: true,
            pauseAutoPlayOnTouch: Duration(seconds: 5),
            height: 200.0,
            items: imgList.map((imgUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
//                          color: Colors.black12
                        ),
                    child: Image.network(
                      imgUrl,
                      fit: BoxFit.contain,
                      width: 600,
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Expanded(
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 0.0),
              children: <Widget>[
                _buildCard("Precautions", 20, 25),
                _buildCard("News", 20, 25),
//                      _buildCard("Symptoms",0,51),
//                      _buildCard("More..",0,51)
              ],
            ),
          )
        ],
      ),
    ));
  }

  Widget _buildCard(String name, double top_pad, double bottom_pad) {
    return Padding(
      padding:
          EdgeInsets.only(top: top_pad, bottom: bottom_pad, left: 5, right: 5),
      child: InkWell(
        onTap: () {},
        child: Container(
//          width: 60,
//          height: 130,
          decoration: BoxDecoration(
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
                        Icons.compare_arrows,
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
