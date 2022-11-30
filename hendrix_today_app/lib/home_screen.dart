import 'package:flutter/material.dart';

var daily_events_list;
var daily_announcements_list;
var daily_meetings_list;

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children:[SizedBox(
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
    ],
    )
    );
  }
}
