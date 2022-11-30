import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import "package:hendrix_today_app/reading_excel.dart";

var daily_events_list;
var daily_announcements_list;
var daily_meetings_list;

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
// var fileTitle = fileParsing("titles");
// var fileType = fileParsing("types");
// var fileDesc = fileParsing("desc");
// var fileDate = fileParsing("dates");

//     List<Card> eventMap(List<String> TiList, DeList, Dalist, TyList){
//      List<Card> cardList = [];
//      int i = 0;
//       TiList.forEach((element){
//         TyList.forEach((tipe){
//           DeList.forEach((desc){
//             Dalist.forEach((date){
//         cardList.add(Card(
//           child: ListTile(
//             title: Text(element), 
//             trailing: Text(date),
//             subtitle: Text(tipe),
//             onTap: () {
//                     AlertDialog alert = AlertDialog(
//                       title: Text(element),
//                       insetPadding:
//                           EdgeInsets.symmetric(vertical: 200, horizontal: 50),
//                       content: Column(children: [
//                         Text(desc)
//                       ]),
//                     );
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return alert;
//                       },
//                     );
//                   },
//             )));
//         i++;
//             });
//         });
//       });
//     });
//       return cardList;
//   }

// //   futureChecker(){
//   FutureBuilder(future: fileTitle,
//     builder: (context, snapshot){
//       if(snapshot.hasData){
//         final GfileTitle = snapshot;
//       }
//       return Text("Failed to Future proof");
//     });
//   }

  // cardMap(List<Card> cards){
  //   cards = eventMap(fileTitle, fileDesc, fileDate, fileType);
  //   cards.forEach((crd) { 
  //     ListView.builder(itemBuilder: (context, crd));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 200,
          child: ListView(
            key: daily_events_list,
            children: <Widget>[
              Image.asset('assets/webOrange_banner.png',
                  key: const Key("Banner")),
              Card(
          child: ListTile(
            title: Text("Event 1"), 
            trailing: Text("Date 1"),
            subtitle: Text("Type"),
            onTap: () {
                    AlertDialog alert = AlertDialog(
                      title: Text("Title 1"),
                      insetPadding:
                          EdgeInsets.symmetric(vertical: 200, horizontal: 50),
                      content: Column(children: [
                        Text("Desc 1")
                      ]),
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  },
            )),
            Card(
          child: ListTile(
            title: Text("Title 2"), 
            trailing: Text("Date 2"),
            subtitle: Text("Type 2"),
            onTap: () {
                    AlertDialog alert = AlertDialog(
                      title: Text("Title 2"),
                      insetPadding:
                          EdgeInsets.symmetric(vertical: 200, horizontal: 50),
                      content: Column(children: [
                        Text("Desc 2")
                      ]),
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  },
            ))     
            ],
          ),
        ),
        Link(
            target: LinkTarget.blank,
            uri: Uri.parse(
                'https://www.hendrix.edu/diningservices/default.aspx?id=1005'),
            builder: (context, followLink) => InkWell(
                  onTap: followLink,
                  child: const Text("Today's Menu"),
                ))
      ],
    ));
  }
}

