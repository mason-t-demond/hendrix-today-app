import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'reading_excel.dart' as rb;
import 'firebase.dart' as fb;

var daily_events_list;
var daily_announcements_list;
var daily_meetings_list;

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  final Stream<QuerySnapshot> _usersStream =
      fb.db.collection('eventsListed').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        //return Center(
        // return Column(
        //   children: [
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          //height: MediaQuery.of(context).size.height - 200,
          child: ListView(
            key: const Key('daily_events_list'),
            children: <Widget>[
              Image.asset('assets/webOrange_banner.png',
                  key: const Key("Banner")),
              //ListView(
              //children:
              ListBody(
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return Card(
                            child: ListTile(
                          title: Text(data["title"]),
                          subtitle: Text(data["date"]),
                          onTap: () {
                            AlertDialog alert = AlertDialog(
                              title: Text(data["title"]),
                              insetPadding: EdgeInsets.symmetric(
                                  vertical: 200, horizontal: 50),
                              content: Column(children: [Text(data["desc"])]),
                            );

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          },
                        ));
                      })
                      .toList()
                      .cast()),
              //),
            ],
          ),
        );
        //],
        //),
        //);
      },
    );
    // return Center(
    //     child: Column(
    //   children: [
    //     SizedBox(
    //       width: MediaQuery.of(context).size.width,
    //       height: MediaQuery.of(context).size.height - 200,
    //       child: ListView(
    //         key: daily_events_list,
    //         children: <Widget>[
    //           Image.asset('assets/webOrange_banner.png',
    //               key: const Key("Banner")),
    //           Card(
    //               elevation: 6.0,
    //               child: ListTile(
    //                 title: Text('Farewell to Dean Wiltgen'),
    //                 subtitle: Text('October 31st, 2-4pm'),
    //                 onTap: () {
    //                   AlertDialog alert = AlertDialog(
    //                     title: Text('Farewell to Dean Wiltgen'),
    //                     insetPadding:
    //                         EdgeInsets.symmetric(vertical: 200, horizontal: 50),
    //                     content: Column(children: [
    //                       Text(
    //                           "You are invited to drop by the SLTC Student Services Suite today from 2-4 p.m. to say farewell to Dean Wiltgen. There will be refreshments while they last!")
    //                     ]),
    //                   );
    //                   showDialog(
    //                     context: context,
    //                     builder: (BuildContext context) {
    //                       return alert;
    //                     },
    //                   );
    //                 },
    //               )),
    //           Card(
    //             elevation: 6.0,
    //             child: ListTile(
    //               title: Text('NATIONAL FRENCH WEEK - Crêpe Extravaganza!'),
    //               subtitle: Text('October 31st, 4-5pm'),
    //               onTap: () {
    //                 AlertDialog alert = AlertDialog(
    //                   title: Text('NATIONAL FRENCH WEEK - Crêpe Extravaganza!'),
    //                   insetPadding:
    //                       EdgeInsets.symmetric(vertical: 200, horizontal: 50),
    //                   content: Column(children: [
    //                     Text(
    //                         "Come out to the SLTC Kitchen today from 4-5 p.m. and help kick off National French Week at our Crêpe extravaganza! All are welcome! Be sure to check out all of the festivities planned this week.")
    //                   ]),
    //                 );
    //                 showDialog(
    //                   context: context,
    //                   builder: (BuildContext context) {
    //                     return alert;
    //                   },
    //                 );
    //               },
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // ));
  }
}
