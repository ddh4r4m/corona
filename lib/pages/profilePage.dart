import 'package:corona/main.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get_it/get_it.dart';


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
class _ProfilePageState extends State<ProfilePage> {
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
                  ),
                )
            ),
            DataCell(Text("104")),

          ],
        ),
      ]

  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("COVID-19 Contact List"),
      ),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: bodyData()),
        ),
      ),

    );
  }
}