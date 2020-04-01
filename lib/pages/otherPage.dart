import 'package:flutter/material.dart';

class CasesReport{
  String stateName;
  int confirmedCases;
  int cured;
  int death;
  CasesReport({this.stateName, this.confirmedCases, this.cured, this.death});
}

String updateStamp="01 April 2020, 09:00 GMT+5:30";

var data= <CasesReport>[
  CasesReport(stateName: 'Andhra Pradesh', confirmedCases: 83, cured: 1, death: 0),
  CasesReport(stateName: 'Andaman and Nicobar Islands', confirmedCases: 10, cured: 0, death: 0),
];

class OtherPage extends StatefulWidget {

  _OtherPageState createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage>{

  void _refresh() {
    setState(() {
    });
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
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID-19 Statewise Status'),
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _refresh();
            },
            tooltip: "Refresh to get recent data from GOI website",
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: bodyData()),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child:Text("Data in GOI website was updated on :\n "+updateStamp),
      ),
    );
  }
}


