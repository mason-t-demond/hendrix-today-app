import 'package:flutter/material.dart';

var daily_events_list;
var daily_announcements_list;
var daily_meetings_list;

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

//got the code for below from: https://firebase.google.com/docs/firestore/query-data/listen#dart_1

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    //builds a snapshot of Firebase at the time its called
    //houses the snapshot in _usersStream
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ListView(
            key: const Key('daily_events_list'),
            children: <Widget>[
              //hendrix today banner
              Image.asset('assets/webOrange_banner.png',
                  key: const Key("Banner")),
              ListBody(
                  //pulls data (events) from snapshot and converts to map
                  //then converts to list
                  //then converts to card
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
            ],
          ),
        );
      },
    );
  }
}
