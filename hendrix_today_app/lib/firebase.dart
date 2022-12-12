import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hendrix_today_app/event_items.dart';

//tell Alexandria thank you for letting us use this code

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

Future getRef()async{
final ref = db.collection("eventsListed").doc("event1").withConverter(
    fromFirestore: Event.fromFirestore,
    toFirestore: (Event event, _) => event.toFirestore(),
    );
final docSnap = await ref.get();
final event = docSnap.data(); // Convert to Event object
if (event != null) {
  print(event);
} else {
  print("No such document.");
}
}
final eventsListed = db.collection("events");
final docRef = db.collection("eventsListed").get().then((value) => null);

