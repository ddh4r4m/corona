import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;


String buttonStatus="Loading...";
bool refreshRequired=true;
class CasesReport{
  String stateName;
  int confirmedCases;
  int cured;
  int death;
  CasesReport({this.stateName, this.confirmedCases, this.cured, this.death});
}

String updateStamp="Swipe down to refresh";
int activeCases=0;
var data= <CasesReport>[
  CasesReport(stateName: 'Please wait connecting to internet...', confirmedCases: 0, cured: 0, death: 0),
];

class OtherPage extends StatefulWidget {

  _OtherPageState createState() => _OtherPageState();
}
Stream classStream(dom.Document document, String tag) async*{
  for(dom.Element element in document.getElementsByClassName(tag)){
    yield element;
  }
}
Stream tagStream(dom.Document document, String tag) async*{
  for(dom.Element element in document.getElementsByTagName(tag)){
    yield element;
  }
}
//Stream tagStream(dom.Document document, String tag) async*{
//  for(dom.Element element in document.getElementsByAlt(tag)){
//    yield element;
//  }
//}
List<String> states=[
  "Andhra Pradesh","Andaman and Nicobar Islands","Assam","Bihar","Chandigarh",
  "Chhattisgarh","Delhi","Goa","Gujarat","Haryana","Himachal Pradesh","Jammu and Kashmir",
  "Jharkhand","Karnataka","Kerala","Ladakh","Madhya Pradesh","Maharashtra","Manipur",
  "Mizoram","Odisha","Puducherry","Punjab","Rajasthan","Tamil Nadu","Telengana",
  "Uttarakhand","Uttar Pradesh","West Bengal"
];

class _OtherPageState extends State<OtherPage>{
  String newStr="###";

  Future<Null> updateComplete() async{
    http.Response response = await http.get('https://www.mohfw.gov.in');
    dom.Document document = parser.parse(response.body);
    List<String> myList=[];
    await for (dom.Element element in tagStream(document,'td')){
      myList.add(element.text);
    }
    int myListLen=myList.length;
    data.clear();activeCases=0;
    for(var stateName in states) {
      for (int index = 0; index < myListLen; ++index) {
        if (myList[index] == stateName) {
          activeCases += int.parse(myList[index + 1]);
          activeCases -= int.parse(myList[index + 2]);
          activeCases -= int.parse(myList[index + 3]);
          data.add(
              CasesReport(
                stateName: myList[index],
                confirmedCases: int.parse(myList[index + 1]),
                cured: int.parse(myList[index + 2]),
                death: int.parse(myList[index + 3]),
              )
          );
        }
      }
    }
    return null;
  }
  Future<Null> getData() async{
    http.Response response = await http.get('https://www.mohfw.gov.in');
    dom.Document document = parser.parse(response.body);
    await for (dom.Element element in classStream(document,'status-update')){
      newStr = element.text;
      return null;
    }
    print(newStr);
    return null;
  }

  Future<Null> _refresh() async{
    await getData();
    if(updateStamp==newStr){return;}
    await updateComplete();
    updateStamp=newStr;
    setState((){

    });
    refreshRequired=false;buttonStatus="active cases";
    return null;
  }
  Widget bodyData() => DataTable(
      columns: <DataColumn>[
        DataColumn(
          label: Text("Name of State / UT"),
          numeric: false,
        ),
        DataColumn(
          label: Text("Confirmed cases"),
          numeric: true,
        ),
        DataColumn(
          label: Text("Cured/Discharged/Migrated"),
          numeric: true,
        ),
        DataColumn(
          label: Text("Death"),
          numeric: true,
        ),
      ],
      rows: data.map(
              (name)=>DataRow(
              cells: [
                DataCell(
                  Text(name.stateName),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text((name.confirmedCases).toString()),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text(name.cured.toString()),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text(name.death.toString()),
                  showEditIcon: false,
                  placeholder: false,
                ),
              ]
          )
      ).toList()
  );

  @override
  Widget build(BuildContext context) {
    if(refreshRequired){_refresh();}
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Status'),
        actions: <Widget>[
          RaisedButton(
            child: Text(
              (refreshRequired?"":activeCases.toString())+" "+buttonStatus,
              style: TextStyle(fontSize: 16),
            ),
            onPressed: _refresh,
          ),
          //Container(child: Text(activeCases.split("\n")[2]+" active cases"))
        ],
      ),
      body: new RefreshIndicator(
        child: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: bodyData(),
            ),
          ),
        ),
        onRefresh: _refresh,
      ),
      bottomNavigationBar: BottomAppBar(
        child:Text(" COVID-19 Status\n "+updateStamp.substring(12)),
        color: Colors.lightGreen,
      ),
    );
  }
}

