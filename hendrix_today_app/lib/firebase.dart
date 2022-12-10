import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hendrix_today_app/event_items.dart';

//tell Alexandria thank you for letting us use this code

//initialize an instance of cloud firestore
final db = FirebaseFirestore.instance; //instance of the database
String userID = "";

//init database collections
//things we will need in the DB
//Examples below:
// final pHCollection = db.collection('pH');
// final zincCollection = db.collection('Zinc');
// final totalChlorineCollection = db.collection('TotalChlorine');

final eventTitle = db.collection('eventTitle');

class Firestore {
  //a class for firestore functions

  // addMeasurement takes in the collection (name in Firestore) and the measurement
  // for the standard. Creates a new document adds fields with the userID, measurement,
  //and timestamp
  static Future addEvent(
      String collection, String title, String description) async {
    await db
        .collection(collection)
        .add({"eventTitle": title, "desc": description});
  }

  //this will give a map of all events
  static Future getEvents(String collection, String title) async {
    await db.collection(collection).get();
  }
}
