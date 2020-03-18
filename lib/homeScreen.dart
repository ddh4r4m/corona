import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> imgList = [
    'https://www.cdc.gov/coronavirus/2019-ncov/images/social/covid-19-symptoms-v03.png',
    'https://ichef.bbci.co.uk/news/208/cpsprodpb/931B/production/_111195673_corona_whatyouneedtodo_without_title-nc.png'
  ];
  final List<String> _myEvents = ["Health", "Precautions"];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.deepPurple,
        title: new Text('COVID-19'),
      ),
      body: SafeArea(
          child: Container(
            color: Colors.black12,
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            padding: EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CarouselSlider(
                  height: 200.0,
                  items: imgList.map((imgUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
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
                        mainAxisSpacing: 0.0
                    ),
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
          )),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.black12,
        buttonBackgroundColor: Colors.white,
        items: <Widget>[

          Icon(
            Icons.add,
            size: 20,
            color: Colors.deepPurple,
          ),
          Icon(Icons.list, size: 20, color: Colors.deepPurple),
          Icon(Icons.healing, size: 20, color: Colors.deepPurple),
          Icon(Icons.compare_arrows, size: 20, color: Colors.deepPurple),
          Icon(Icons.map, size: 20, color: Colors.deepPurple)
        ],
        index: 2,
      ),
    );
  }

  Widget _buildCard(String name, double top_pad, double bottom_pad) {
    return Padding(
      padding: EdgeInsets.only(
          top: top_pad, bottom: bottom_pad, left: 5, right: 5),
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
                end: new Alignment(-1.0, -1.0)
            ),
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
                        Icons.compare_arrows, size: 40, color: Colors.white,),
                      backgroundColor: Colors.white.withOpacity(0.2),
                    )
                    ,
                    SizedBox(height: 20.0,),
                    Text(name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0
                      ),
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
