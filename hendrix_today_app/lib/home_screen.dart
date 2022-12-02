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
var fileTitle = fileParsing("titles");
var fileType = fileParsing("types");
var fileDesc = fileParsing("desc");
var fileDate = fileParsing("dates");

    List<Card> eventMap(List<String> TiList, DeList, Dalist, TyList){
     List<Card> cardList = [];
     int i = 0;
      TiList.forEach((element){
        TyList.forEach((tipe){
          DeList.forEach((desc){
            Dalist.forEach((date){
        cardList.add(Card(
          child: ListTile(
            title: Text(element), 
            trailing: Text(date),
            subtitle: Text(tipe),
            onTap: () {
                    AlertDialog alert = AlertDialog(
                      title: Text(element),
                      insetPadding:
                          EdgeInsets.symmetric(vertical: 200, horizontal: 50),
                      content: Column(children: [
                        Text(desc)
                      ]),
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  },
            )));
        i++;
            });
        });
      });
    });
      return cardList;
  }

  // futureChecker(){
  // FutureBuilder(future: fileTitle,
  //   builder: (context, snapshot){
  //     if(snapshot.hasData){
  //       final GfileTitle = snapshot;
  //     }
  //     return Text("Failed to Future proof");
  //   });
  // }

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
            title: Text("TEC Talk Less, Smile More Policy Battles"), 
            trailing: Text("12/02/2022"),
            subtitle: Text("Event"),
            onTap: () {
                    AlertDialog alert = AlertDialog(
                      title: Text("TEC Talk Less, Smile More Policy Battles"),
                      insetPadding:
                          EdgeInsets.symmetric(vertical: 200, horizontal: 50),
                      content: Column(children: [
                        Text("Join the Talk Less, Smile More TEC class for performances of their Policy Battles. In these battles, performers will artistically debate about immigration and environmental policies. Two performances: today, and Friday, Dec. 2, from 12:10 -1 p.m. in Hundley-Shell Theater.")
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
            title: Text("KHDX Rave Wristbands!"), 
            subtitle: Text("Announcement"),
            onTap: () {
                    AlertDialog alert = AlertDialog(
                      title: Text("KHDX Rave Wristbands!"),
                      insetPadding:
                          EdgeInsets.symmetric(vertical: 200, horizontal: 50),
                      content: Column(children: [
                        Text("KHDX is handing out wristbands for the Rave this week! Wednesday and Friday from 11-2 and Thursday from 4-7 p.m. Guests will be registered during these times and must bring their ID for entry at the door. Rave is Dec. 2, 9 p.m.–1 a.m. in Worsham.")
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
            title: Text("DANC 250 Dance Making Fundamentals Final Performances"), 
            trailing: Text("12/06/2022"),
            subtitle: Text("Event"),
            onTap: () {
                    AlertDialog alert = AlertDialog(
                      title: Text("DANC 250 Dance Making Fundamentals Final Performances"),
                      insetPadding:
                          EdgeInsets.symmetric(vertical: 200, horizontal: 50),
                      content: Column(children: [
                        Text("On Dec. 6 at 10:30 a.m. in Trieschmann Dance Studio, students will perform final choreographic projects and hold a Q&A after all 14 solo pieces have been performed. ")
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

