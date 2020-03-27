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

List<Item> _buildFaq(){
  var items = new List<Item>();
  items.add(new Item(headerValue: 'What is a coronavirus?',expandedValue: 'Coronaviruses are a large family of viruses which may cause illness in animals or humans.  In humans, several coronaviruses are known to cause respiratory infections ranging from the common cold to more severe diseases such as Middle East Respiratory Syndrome (MERS) and Severe Acute Respiratory Syndrome (SARS). The most recently discovered coronavirus causes coronavirus disease COVID-19.'));
  items.add(new Item(headerValue: 'What is COVID-19?',expandedValue: 'COVID-19 is the infectious disease caused by the most recently discovered coronavirus. This new virus and disease were unknown before the outbreak began in Wuhan, China, in December 2019.'));
  items.add(new Item(headerValue: 'What are the symptoms of COVID-19?',expandedValue: "The most common symptoms of COVID-19 are fever, tiredness, and dry cough. Some patients may have aches and pains, nasal congestion, runny nose, sore throat or diarrhea. These symptoms are usually mild and begin gradually. Some people become infected but don’t develop any symptoms and don't feel unwell. Most people (about 80%) recover from the disease without needing special treatment. Around 1 out of every 6 people who gets COVID-19 becomes seriously ill and develops difficulty breathing. Older people, and those with underlying medical problems like high blood pressure, heart problems or diabetes, are more likely to develop serious illness. People with fever, cough and difficulty breathing should seek medical attention."));
  items.add(new Item(headerValue: 'How does COVID-19 spread?',expandedValue: 'myvalue1'));
  items.add(new Item(headerValue: 'mytext',expandedValue: 'myvalue2'));
  items.add(new Item(headerValue: 'mytext',expandedValue: 'myvalue1'));
  items.add(new Item(headerValue: 'mytext',expandedValue: 'myvalue2'));
  items.add(new Item(headerValue: 'mytext',expandedValue: 'myvalue1'));
  items.add(new Item(headerValue: 'mytext',expandedValue: 'myvalue2'));
  items.add(new Item(headerValue: 'mytext',expandedValue: 'myvalue1'));
  items.add(new Item(headerValue: 'mytext',expandedValue: 'myvalue2'));
  items.add(new Item(headerValue: 'mytext',expandedValue: 'myvalue1'));
  items.add(new Item(headerValue: 'mytext',expandedValue: 'myvalue2'));
  items.add(new Item(headerValue: 'mytext',expandedValue: 'myvalue1'));
  items.add(new Item(headerValue: 'mytext',expandedValue: 'myvalue2'));
  items.add(new Item(headerValue: 'mytext',expandedValue: 'myvalue1'));
  items.add(new Item(headerValue: 'mytext',expandedValue: 'myvalue2'));

  return items;
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
//  List<Item> _buildFaq(){
//    var items = new List<Item>();
//    items.add(new Item(headerValue: 'mytext',expandedValue: 'myvalue'));
//    return items;
//  }

List<Item> _data = _buildFaq();//generateItems(8);
//

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'FAQs',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                )),
            _buildPanel()
          ],
        ),
//        child: _buildPanel(),
      ),
    );
  }
//@override
//Widget build(BuildContext context) {
//  return Column(
//    children: <Widget>[
//      Expanded(
//
//
//      child: Container(
//        margin: EdgeInsets.only(top: 20),
//        padding: EdgeInsets.only(top: 10),
//        child: Align(
//          alignment: Alignment.centerLeft,
//          child: Text(
//          'FAQs',
//          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//          textAlign: TextAlign.left,
//                  ),
//      ))),
//
//      SingleChildScrollView(
//        child: Container(
//          child: _buildPanel(),
//  ),
//  )
//    ],
//  );
//}

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
              }
          );
        },
        body:Container(
            child:InkWell(
              child:  ListTile(
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
            )),
        isExpanded: item.isExpanded,
      );
    }).toList(),
  );
}
}
