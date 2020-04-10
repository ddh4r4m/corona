import 'dart:async';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ProfilePage extends StatefulWidget {

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

List<String> states=[
  "Andhra Pradesh","Andaman and Nicobar Islands","Assam","Bihar","Chandigarh",
  "Chhattisgarh","Delhi","Goa","Gujarat","Haryana","Himachal Pradesh","Jammu and Kashmir",
  "Jharkhand","Karnataka","Kerala","Ladakh","Madhya Pradesh","Maharashtra","Manipur",
  "Mizoram","Odisha","Puducherry","Punjab","Rajasthan","Tamil Nadu","Telengana",
  "Uttarakhand","Uttar Pradesh","West Bengal"
];


String uid = null;
class _ProfilePageState extends State<ProfilePage> {


//initState called when the widget is mounted.
  void initState() {
    super.initState();
    if(uid == null){
      getUserId().then(
              (String s) => setState(() {uid = s;})
      );

    }
  }


  void startServiceInPlatform() async {
    if (Platform.isAndroid) {
      var methodChannel = MethodChannel("com.example.corona");
      String data = await methodChannel.invokeMethod("startService");
      debugPrint(data);
    }
  }


  void checkStatus() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    QuerySnapshot homeLocn = await Firestore.instance.collection("Users")
        .getDocuments();
    homeLocn.documents.forEach((f) => print(f["name"]));
    QuerySnapshot markerData = await Firestore.instance.collection("Markers")
        .getDocuments();
//    markerData.documents.map(
//        (fdata)=> if(fdata["victim"]){
//          print("J")
//              return null;
//    }
//    );

//    Stream<QuerySnapshot> userlocn = await Firestore.instance.collection("Markers").getDocuments();
//    userlocn.documents.forEach((f)=>print(f["location"]));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('COVID-19 Contact List')),
      body:Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: bodyData()),
        ),
      ),

//      Center(
//            child: RaisedButton(
//                child: Text("Start Background"),
//                onPressed: () {
//                  startServiceInPlatform();
//                  checkStatus();
//                }
//
//            ),
//          )
//          _buildBody(context),
    );


//      Container(
//      child: Column(
//        children: <Widget>[
//          Column(
//            children: <Widget>[
//              StreamBuilder<QuerySnapshot>(
//                stream: Firestore.instance.collection('Markers').snapshots(),
//                //_myMarkers,
//                builder: (context, snapshot) {
//                  if (snapshot.hasError) {
//                    return Center(child: Text('Error: ${snapshot.error}'),);
//                  }
//                  if (!snapshot.hasData) {
//                    return Center(child: const Text('Loading...Bro'),);
//                  }
////                return victimsMap(documents: snapshot.data.documents,);
//                  return SingleChildScrollView(
//                  child:_buildList(context, snapshot.data.documents)
//                  );
////                      Column(
////                      children: <Widget>[
////                        snapshot.data.documents.map(f)
////                        Flexible(
////                          flex: 1,
////                          child: Text("snapshot.data.documents.map(f)")
////                        )
////                      ],
////
////                    );
//                  final mapData = snapshot.data.documents;
//                },
//              ),
//            ],
//          ),
//          Center(
//            child: RaisedButton(
//                child: Text("Start Background"),
//                onPressed: () {
//                  startServiceInPlatform();
//                  checkStatus();
//                }
//
//            ),
//          )
//        ],
//      ),
////      child:
//    );
  }
}

  Future<String> getUserId() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String userid = await user.uid;
    print('This is UId');
    print (userid);
    return userid;
  }



//where("userid",isEqualTo: uid)
Widget _buildBody(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection('Markers').snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return LinearProgressIndicator();
      return _buildList(context, snapshot.data.documents);
      return new ListView(
        children: snapshot.data.documents.map((documents){
          if(documents["userid"]!=uid){
            return new ListTile(
              title: new Text(documents["userid"].toString()),
            );
          }else{
            return new ListTile(
              title: new Text("documents[].toString()"),
            );
          }

        }).toList(),
      );
      });
//      return _buildList(context, snapshot.data.documents);
    }
//
//List<Record> applyFilter(
//  String filter, List<Record> records
//){
//  return Firestore.instance.collection("Markers").where("userid",isEqualTo: uid).getDocuments()
//}


Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
//var record;
//  print("hi");
//  snapshot.map((f)=>
//      record = Record.fromSnapshot(f),
//    snapshot.removeWhere((test)=>test)
//  );
//  snapshot.removeWhere((item)=>item.userid==uid);
//  for(var i=0;i<snapshot.length;i++){
//    print(snapshot)
//  }
  print(snapshot);
//  final List<DocumentSnapshot> userList = snapshot.removeWhere((DocumentSnapshot documentSnapshot) => documentSnapshot['userId'] != id).toList(););
//  userList.removeWhere((DocumentSnapshot documentSnapshot) => documentSnapshot['userId'] != id).toList();
  snapshot.map((f)=>print(Record.fromSnapshot(f)));
  return Column(
    children: <Widget>[
      Expanded(
         child: ListView(
              padding: const EdgeInsets.only(top: 20.0),
              children: snapshot.map((data) =>
                  _buildListItem(context, data)
              )
                  .toList()
          )
      )

]

  );

}


  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);
    String userId = uid;
//    print(record.name);
//    print(uid);
//    print(userId);
//    print(getUserId());
    if(record.name!=uid){
      return Padding(
          key: ValueKey(record.name),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: ListTile(
              title: Text(record.name),
              trailing: Text(record.votes.toString()),
//          onTap: () =>
//              record.reference.updateData({'votes': FieldValue.increment(1)}),),
            ),
          ));
    }else{
      return SizedBox(height: 1);
//      return Text(' ');
    }

  }


Widget bodyData() => DataTable(
    columns: <DataColumn>[
      DataColumn(
        label: Text("State/UT"),
        numeric: false,
      ),
      DataColumn(
        label: Text("Dial"),
        numeric: false,
      ),
      DataColumn(
        label: Text("Helpline Number"),
        numeric: true,
      )
    ],
    rows: <DataRow>[
      DataRow(
        cells: [
          DataCell(Text("Andhra Pradesh")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:+0866-2410978';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("0866-2410978")),

        ],

      ),
      DataRow(
        cells: [
          DataCell(Text("Arunachal Pradesh")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:9436055743';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("9436055743")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Assam")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:6913347770';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("6913347770")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Bihar")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:104';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("104")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Chhattisgarh")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:104';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("104")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Goa")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:104';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("104")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Gujrat")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:104';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("104")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Haryana")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:8558893911';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("8558893911")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Himanchal Pradesh")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:+104';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("104")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Jharkhand")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:104';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("104")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Karnataka")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:104';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("104")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Kerala")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:0471-2552056';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("0471-2552056")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Madhya Pradesh")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:104';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("104")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Maharashtra")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:020-26127394';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("020-26127394")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Manipur")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:3852411668';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("3852411668")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Meghalaya")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:108';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("108")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Mizoram")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:102';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("102")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Nagaland")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:7005539653';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("7005539653")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Punjab")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:104';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("104")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Rajasthan")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:0141-2225624';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("0141-2225624")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Sikkim")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:104';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("104")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Tamil Nadu")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:044-29510500';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("044-29510500")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Telangana")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:104';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("104")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Tripura")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:0381-2315879';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("0381-2315879")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Uttarakhand")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:104';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("104")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Uttar Pradesh")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:18001805145';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("18001805145")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("West Bengal")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:1800313444222';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("1800313444222 ,03323412600")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Andaman and Nicobar Islands")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:03192-232102';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("03192-232102")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Chandigarh")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:9779558282';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("9779558282")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Uttarakhand")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:104';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("104")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Delhi")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:011-22307145';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("011-22307145")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Jammu & Kashmir ")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:01912520982';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("01912520982,0194-2440283")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Ladakh")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:01982256462';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("01982256462")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Lakshadweep")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:104';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("104")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Puducherry")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:104';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("104")),

        ],
      ),
      DataRow(
        cells: [
          DataCell(Text("Dadra and Nagar Haveli and Daman & Diu")),
          DataCell(
              RaisedButton(
                onPressed: () async{
                  const url='tel:104';
                  if(await canLaunch(url)){
                    await launch(url);
                  }
                  else{
                    throw 'Could not launch $url';
                  }
                },
                child: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              )
          ),
          DataCell(Text("104")),

        ],
      ),
    ]

);















class Record {
  final String name;
  final String votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['userid'] != null),
        assert(map['userid'] != null),
        name = map['userid'],
        votes = map['userid'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$votes>";
}
