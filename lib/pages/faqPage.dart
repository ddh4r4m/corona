import 'package:flutter/material.dart';

class faqPage  extends StatefulWidget {

  @override
  _faqPageState createState() => _faqPageState();
}

class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}


List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}

class _faqPageState extends State<faqPage > {
// stores ExpansionPanel state information


// ...

List<Item> _data = generateItems(8);

@override
Widget build(BuildContext context) {
  return Column(
    children: <Widget>[
      Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.only(top: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
          'FAQs',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
                  ),
      )),

  SingleChildScrollView(
  child: Container(
  child: _buildPanel(),
  ),
  )
    ],
  );
}

Widget _buildPanel() {
  return ExpansionPanelList(
    expansionCallback: (int index, bool isExpanded) {
      setState(() {
        _data[index].isExpanded = !isExpanded;
      });
    },
    children: _data.map<ExpansionPanel>((Item item) {
      return ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return ListTile(
            title: Text(item.headerValue),
            onTap: () {
              setState(() {
                item.isExpanded = !isExpanded;
              });
            },
          );
        },
        body: Column(
          children: <Widget>[
            Text('Frequently Asked Questions'),
            ListTile(
                title: Text(item.expandedValue),
//            subtitle: Text('To delete this panel, tap the trash can icon'),
//            trailing: Icon(Icons.delete),
                onTap: () {
                  setState(() {
//                item.isExpanded = !isExpanded;
//                _data.removeWhere((currentItem) => item == currentItem);
                  });
                }
            ),
          ],
        ),
        isExpanded: item.isExpanded,
      );
    }).toList(),
  );
}
}
