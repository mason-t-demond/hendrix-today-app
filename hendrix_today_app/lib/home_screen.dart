import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

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
                  elevation: 6.0,
                  child: ListTile(
                    title: Text('Farewell to Dean Wiltgen'),
                    subtitle: Text('October 31st, 2-4pm'),
                    onTap: () {
                      AlertDialog alert = AlertDialog(
                        title: Text('Farewell to Dean Wiltgen'),
                        insetPadding:
                            EdgeInsets.symmetric(vertical: 200, horizontal: 50),
                        content: Column(children: [
                          Text(
                              "You are invited to drop by the SLTC Student Services Suite today from 2-4 p.m. to say farewell to Dean Wiltgen. There will be refreshments while they last!")
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
                elevation: 6.0,
                child: ListTile(
                  title: Text('NATIONAL FRENCH WEEK - Crêpe Extravaganza!'),
                  subtitle: Text('October 31st, 4-5pm'),
                  onTap: () {
                    AlertDialog alert = AlertDialog(
                      title: Text('NATIONAL FRENCH WEEK - Crêpe Extravaganza!'),
                      insetPadding:
                          EdgeInsets.symmetric(vertical: 200, horizontal: 50),
                      content: Column(children: [
                        Text(
                            "Come out to the SLTC Kitchen today from 4-5 p.m. and help kick off National French Week at our Crêpe extravaganza! All are welcome! Be sure to check out all of the festivities planned this week.")
                      ]),
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  },
                ),
              )
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
