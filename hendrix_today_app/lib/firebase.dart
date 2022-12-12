import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hendrix_today_app/event_items.dart';
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:firebase_ui_auth/firebase_ui_auth.dart'; 
import 'package:hendrix_today_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart' // new

    hide
        EmailAuthProvider,
        PhoneAuthProvider; 

//initialize an instance of cloud firestore
final db = FirebaseFirestore.instance; //instance of the database
String userID = "";

class Event {
  final String? title;
  final String? desc;
  final String? time;
  final String? date;

  Event({
    this.title,
    this.desc,
    this.time,
    this.date,
  });

  factory Event.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Event(
      title: data?['title'],
      date: data?['date'],
      desc: data?['desc'],
      time: data?['time'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) "title": title,
      if (date != null) "date": date,
      if (time != null) "time": time,
      if (desc != null) "desc": desc,
    };
  }
}

Future getRef() async {
  final ref = db.collection("eventsListed").doc("event1").withConverter(
        fromFirestore: Event.fromFirestore,
        toFirestore: (Event event, _) => event.toFirestore(),
      );
  final docSnap = await ref.get();
  final event = docSnap.data(); // Convert to Event object
  if (event != null) {
    return (event);
  } else {
    return ("No such document.");
  }
}

//should return a Future<Map<String, String>>
getEvents() async {
  Map dic = {};
  final events = await db.collection('eventsListed').get();
  for (var e in events.docs) {
    //return (e.data())
    Map d = e.data();
    d.values.toString();
    dic = d;
  }
  return dic;
}


class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream =
      db.collection('eventslisted').snapshots();

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

        return ListView(
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['title']),
                  subtitle: Text(data['date']),
                );
              })
              .toList()
              .cast(),
        );
      },
    );
  }
}
