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
  items.add(new Item(headerValue: 'What can I do to protect myself and prevent the spread of disease?',expandedValue: 'Protection measures for everyone\nStay aware of the latest information on the COVID-19 outbreak, available on the WHO website and through your national and local public health authority. Many countries around the world have seen cases of COVID-19 and several have seen outbreaks. Authorities in China and some other countries have succeeded in slowing or stopping their outbreaks. However, the situation is unpredictable so check regularly for the latest news.\nYou can reduce your chances of being infected or spreading COVID-19 by taking some simple precautions:\nRegularly and thoroughly clean your hands with an alcohol-based hand rub or wash them with soap and water.\nWhy? Washing your hands with soap and water or using alcohol-based hand rub kills viruses that may be on your hands.\nMaintain at least 1 metre (3 feet) distance between yourself and anyone who is coughing or sneezing. Why? When someone coughs or sneezes they spray small liquid droplets from their nose or mouth which may contain virus. If you are too close, you can breathe in the droplets, including the COVID-19 virus if the person coughing has the disease.\nAvoid touching eyes, nose and mouth. Why? Hands touch many surfaces and can pick up viruses. Once contaminated, hands can transfer the virus to your eyes, nose or mouth. From there, the virus can enter your body and can make you sick.\nMake sure you, and the people around you, follow good respiratory hygiene. This means covering your mouth and nose with your bent elbow or tissue when you cough or sneeze. Then dispose of the used tissue immediately. Why? Droplets spread virus. By following good respiratory hygiene you protect the people around you from viruses such as cold, flu and COVID-19.\nStay home if you feel unwell. If you have a fever, cough and difficulty breathing, seek medical attention and call in advance. Follow the directions of your local health authority. Why? National and local authorities will have the most up to date information on the situation in your area. Calling in advance will allow your health care provider to quickly direct you to the right health facility. This will also protect you and help prevent spread of viruses and other infections.\nKeep up to date on the latest COVID-19 hotspots (cities or local areas where COVID-19 is spreading widely). If possible, avoid traveling to places  – especially if you are an older person or have diabetes, heart or lung disease. Why? You have a higher chance of catching COVID-19 in one of these areas.'));
  items.add(new Item(headerValue: 'How does COVID-19 spread?',expandedValue: 'People can catch COVID-19 from others who have the virus. The disease can spread from person to person through small droplets from the nose or mouth which are spread when a person with COVID-19 coughs or exhales. These droplets land on objects and surfaces around the person. Other people then catch COVID-19 by touching these objects or surfaces, then touching their eyes, nose or mouth. People can also catch COVID-19 if they breathe in droplets from a person with COVID-19 who coughs out or exhales droplets. This is why it is important to stay more than 1 meter (3 feet) away from a person who is sick.WHO is assessing ongoing research on the ways COVID-19 is spread and will continue to share updated findings.    '));
  items.add(new Item(headerValue: 'Can the virus that causes COVID-19 be transmitted through the air?',expandedValue: 'Studies to date suggest that the virus that causes COVID-19 is mainly transmitted through contact with respiratory droplets rather than through the air.  See previous answer on “How does COVID-19 spread?”'));
  items.add(new Item(headerValue: 'Can CoVID-19 be caught from a person who has no symptoms?',expandedValue: 'The main way the disease spreads is through respiratory droplets expelled by someone who is coughing. The risk of catching COVID-19 from someone with no symptoms at all is very low. However, many people with COVID-19 experience only mild symptoms. This is particularly true at the early stages of the disease. It is therefore possible to catch COVID-19 from someone who has, for example, just a mild cough and does not feel ill.  WHO is assessing ongoing research on the period of transmission of COVID-19 and will continue to share updated findings.'));
  items.add(new Item(headerValue: 'Can I catch COVID-19 from the feces of someone with the disease?',expandedValue: 'The risk of catching COVID-19 from the feces of an infected person appears to be low. While initial investigations suggest the virus may be present in feces in some cases, spread through this route is not a main feature of the outbreak. WHO is assessing ongoing research on the ways COVID-19 is spread and will continue to share new findings. Because this is a risk, however, it is another reason to clean hands regularly, after using the bathroom and before eating.'));
  items.add(new Item(headerValue: 'How likely I am to catch COVID-19?',expandedValue: 'The risk depends on where you  are - and more specifically, whether there is a COVID-19 outbreak unfolding there. For most people in most locations the risk of catching COVID-19 is still low. However, there are now places around the world (cities or areas) where the disease is spreading. For people living in, or visiting, these areas the risk of catching COVID-19 is higher. Governments and health authorities are taking vigorous action every time a new case of COVID-19 is identified. Be sure to comply with any local restrictions on travel, movement or large gatherings. Cooperating with disease control efforts will reduce your risk of catching or spreading COVID-19. COVID-19 outbreaks can be contained and transmission stopped, as has been shown in China and some other countries. Unfortunately, new outbreaks can emerge rapidly. It\’s important to be aware of the situation where you are or intend to go. WHO publishes daily updates on the COVID-19 situation worldwide. You can see these at https://www.who.int/emergencies/diseases/novel-coronavirus-2019/situation-reports/'));
  items.add(new Item(headerValue: 'Should I worry about COVID-19?',expandedValue: 'Illness due to COVID-19 infection is generally mild, especially for children and young adults. However, it can cause serious illness: about 1 in every 5 people who catch it need hospital care. It is therefore quite normal for people to worry about how the COVID-19 outbreak will affect them and their loved ones. We can channel our concerns into actions to protect ourselves, our loved ones and our communities. First and foremost among these actions is regular and thorough hand-washing and good respiratory hygiene. Secondly, keep informed and follow the advice of the local health authorities including any restrictions put in place on travel, movement and gatherings. Learn more about how to protect yourself at https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public'));
  items.add(new Item(headerValue: 'Who is at risk of developing severe illness?',expandedValue: 'While we are still learning about how COVID-2019 affects people, older persons and persons with pre-existing medical conditions (such as high blood pressure, heart disease, lung disease, cancer or diabetes)  appear to develop serious illness more often than others. '));
  items.add(new Item(headerValue: 'Are antibiotics effective in preventing or treating the COVID-19?',expandedValue: 'No. Antibiotics do not work against viruses, they only work on bacterial infections. COVID-19 is caused by a virus, so antibiotics do not work. Antibiotics should not be used as a means of prevention or treatment of COVID-19. They should only be used as directed by a physician to treat a bacterial infection. '));
  items.add(new Item(headerValue: 'Are there any medicines or therapies that can prevent or cure COVID-19?',expandedValue: 'While some western, traditional or home remedies may provide comfort and alleviate symptoms of COVID-19, there is no evidence that current medicine can prevent or cure the disease. WHO does not recommend self-medication with any medicines, including antibiotics, as a prevention or cure for COVID-19. However, there are several ongoing clinical trials that include both western and traditional medicines. WHO will continue to provide updated information as soon as clinical findings are available.'));
  items.add(new Item(headerValue: 'Is there a vaccine, drug or treatment for COVID-19?',expandedValue: 'Not yet. To date, there is no vaccine and no specific antiviral medicine to prevent or treat COVID-2019. However, those affected should receive care to relieve symptoms. People with serious illness should be hospitalized. Most patients recover thanks to supportive care. Possible vaccines and some specific drug treatments are under investigation. They are being tested through clinical trials. WHO is coordinating efforts to develop vaccines and medicines to prevent and treat COVID-19. The most effective ways to protect yourself and others against COVID-19 are to frequently clean your hands, cover your cough with the bend of elbow or tissue, and maintain a distance of at least 1 meter (3 feet) from people who are coughing or sneezing. (See Basic protective measures against the new coronavirus).'));
  items.add(new Item(headerValue: 'Is COVID-19 the same as SARS?',expandedValue: 'No. The virus that causes COVID-19 and the one that caused the outbreak of Severe Acute Respiratory Syndrome (SARS) in 2003 are related to each other genetically, but the diseases they cause are quite different. SARS was more deadly but much less infectious than COVID-19. There have been no outbreaks of SARS anywhere in the world since 2003.'));
  items.add(new Item(headerValue: 'Should I wear a mask to protect myself?',expandedValue: 'Only wear a mask if you are ill with COVID-19 symptoms (especially coughing) or looking after someone who may have COVID-19. Disposable face mask can only be used once. If you are not ill or looking after someone who is ill then you are wasting a mask. There is a world-wide shortage of masks, so WHO urges people to use masks wisely. WHO advises rational use of medical masks to avoid unnecessary wastage of precious resources and mis-use of masks  (see Advice on the use of masks). The most effective ways to protect yourself and others against COVID-19 are to frequently clean your hands, cover your cough with the bend of elbow or tissue and maintain a distance of at least 1 meter (3 feet) from people who are coughing or sneezing. See basic protective measures against the new coronavirus for more information.'));
  items.add(new Item(headerValue: 'How to put on, use, take off and dispose of a mask?',expandedValue: '1. Remember, a mask should only be used by health workers, care takers, and individuals with respiratory symptoms, such as fever and cough.\n2. Before touching the mask, clean hands with an alcohol-based hand rub or soap and water\n3. Take the mask and inspect it for tears or holes.\n4. Orient which side is the top side (where the metal strip is).\n5. Ensure the proper side of the mask faces outwards (the coloured side).\n6. Place the mask to your face. Pinch the metal strip or stiff edge of the mask so it moulds to the shape of your nose.\n7. Pull down the mask’s bottom so it covers your mouth and your chin.\n8. After use, take off the mask; remove the elastic loops from behind the ears while keeping the mask away from your face and clothes, to avoid touching potentially contaminated surfaces of the mask.\n9. Discard the mask in a closed bin immediately after use.\n10. Perform hand hygiene after touching or discarding the mask \– Use alcohol based hand rub or, if visibly soiled, wash your hands with soap and water.'));
  items.add(new Item(headerValue: 'How long is the incubation period for COVID-19?',expandedValue: 'The “incubation period” means the time between catching the virus and beginning to have symptoms of the disease. Most estimates of the incubation period for COVID-19 range from 1-14 days, most commonly around five days. These estimates will be updated as more data become available.'));
  items.add(new Item(headerValue: 'Can humans become infected with the COVID-19 from an animal source?',expandedValue: 'Coronaviruses are a large family of viruses that are common in animals. Occasionally, people get infected with these viruses which may then spread to other people. For example, SARS-CoV was associated with civet cats and MERS-CoV is transmitted by dromedary camels. Possible animal sources of COVID-19 have not yet been confirmed. To protect yourself, such as when visiting live animal markets, avoid direct contact with animals and surfaces in contact with animals. Ensure good food safety practices at all times. Handle raw meat, milk or animal organs with care to avoid contamination of uncooked foods and avoid consuming raw or undercooked animal products.'));
  items.add(new Item(headerValue: 'Can I catch COVID-19 from my pet?',expandedValue: 'While there has been one instance of a dog being infected in Hong Kong, to date, there is no evidence that a dog, cat or any pet can transmit COVID-19. COVID-19 is mainly spread through droplets produced when an infected person coughs, sneezes, or speaks. To protect yourself, clean your hands frequently and thoroughly. WHO continues to monitor the latest research on this and other COVID-19 topics and will update as new findings are available.'));
  items.add(new Item(headerValue: 'How long does the virus survive on surfaces?',expandedValue: 'It is not certain how long the virus that causes COVID-19 survives on surfaces, but it seems to behave like other coronaviruses. Studies suggest that coronaviruses (including preliminary information on the COVID-19 virus) may persist on surfaces for a few hours or up to several days. This may vary under different conditions (e.g. type of surface, temperature or humidity of the environment). If you think a surface may be infected, clean it with simple disinfectant to kill the virus and protect yourself and others. Clean your hands with an alcohol-based hand rub or wash them with soap and water. Avoid touching your eyes, mouth, or nose.'));
  items.add(new Item(headerValue: 'Is it safe to receive a package from any area where COVID-19 has been reported?',expandedValue: 'Yes. The likelihood of an infected person contaminating commercial goods is low and the risk of catching the virus that causes COVID-19 from a package that has been moved, travelled, and exposed to different conditions and temperature is also low. '));
  items.add(new Item(headerValue: 'Is there anything I should not do?',expandedValue: 'The following measures ARE NOT effective against COVID-2019 and can be harmful:\n-Smoking\n-Wearing multiple masks\n-Taking antibiotics (See question 10 "Are there any medicines of therapies that can prevent or cure COVID-19?"\n\nIn any case, if you have fever, cough and difficulty breathing seek medical care early to reduce the risk of developing a more severe infection and be sure to share your recent travel history with your health care provider.'));
  items.add(new Item(headerValue: 'Is the source of the coronavirus causing COVID-19 known?',expandedValue: 'Currently, the source of SARS-CoV-2, the coronavirus (CoV) causing COVID-19 is unknown. All available evidence suggests that SARS-CoV-2 has a natural animal origin and is not a constructed virus. SARS-CoV-2 virus most probably has its ecological reservoir in bats. SARS-CoV-2, belongs to a group of genetically related viruses, which also include SARS-CoV and a number of other CoVs isolated from bats populations. MERS-CoV also belongs to this group, but is less closely related.'));
  items.add(new Item(headerValue: 'How did the first human SARS-CoV-2 infections occur?',expandedValue: 'The first human cases of COVID-19 were identified in Wuhan City, China in December 2019. At this stage, it is not possible to determine precisely how humans in China were initially infected with SARS-CoV-2.\nHowever, SARS-CoV, the virus which caused the SARS outbreak in 2003, jumped from an animal reservoir (civet cats, a farmed wild animal) to humans and then spread between humans. In a similar way, it is thought that SARS-CoV-2 jumped the species barrier and initially infected humans, but more likely through an intermediate host, that is another animal species more likely to be handled by humans - this could be a domestic animal, a wild animal, or a domesticated wild animal and, as of yet, has not been identified.\nUntil the source of this virus is identified and controlled, there is a risk of reintroduction of the virus in the human population and the risk of new outbreaks like the ones we are currently experiencing.'));
  //items.add(new Item(headerValue: 'mytext',expandedValue: 'myvalue2'));
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 25),
                  padding: EdgeInsets.fromLTRB(15,15,15,20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'FAQs',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: 1.1),
                      textAlign: TextAlign.left,
                    ),
                  )),
              _buildPanel()
            ],
          ),
//        child: _buildPanel(),
        ),
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
              title: Text(item.headerValue,style: TextStyle(fontWeight: FontWeight.bold),),
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
                  title: Text(item.expandedValue, style: TextStyle(fontStyle: FontStyle.italic)),
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
