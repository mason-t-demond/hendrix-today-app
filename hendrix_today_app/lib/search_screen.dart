import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'reading_excel.dart' as rb;
import 'firebase.dart' as fb;
//https://pub.dev/packages/anim_search_bar/example
import 'package:anim_search_bar/anim_search_bar.dart';

// class UserInformation extends StatefulWidget {
//   @override
//   _UserInformationState createState() => _UserInformationState();
// }

// class _UserInformationState extends State<UserInformation> {
//   final Stream<QuerySnapshot> _usersStream =
//       fb.db.collection('eventsListed').snapshots();

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _usersStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return const Text('Something went wrong');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Text("Loading");
//         }

//         return ListView(
//           children: snapshot.data!.docs
//               .map((DocumentSnapshot document) {
//                 Map<String, dynamic> data =
//                     document.data()! as Map<String, dynamic>;
//                 return ListTile(
//                   title: Text(data['title']),
//                   subtitle: Text(data['date']),
//                 );
//               })
//               .toList()
//               .cast(),
//         );
//       },
//     );
//   }
// }

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
// //search screen needs search bar
// //Search bar requires keyboard access and related stuff
// //search needs to display relevant events in ToDoList/listTile form
// class _SearchScreenState extends State<SearchScreen> {
//   Color webOrange = const Color.fromARGB(255, 202, 81, 39);
//   TextEditingController textController = TextEditingController();

//   getEventsFromDynamic() {
//     return fb.getEvents()[1];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: Column(
//       children: [
//         SizedBox(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height - 200,
//           child: ListView(
//             //key: daily_events_list,
//             children: <Widget>[
//               AnimSearchBar(
//                   width: 500,
//                   textController: textController,
//                   onSuffixTap: textController.text = ''),
//               Card(
//                   elevation: 6.0,
//                   child: ListTile(
//                     title: Text('$getEventsFromDynamic()'),
//                     subtitle: Text(''),
//                     onTap: () {
//                       AlertDialog alert = AlertDialog(
//                         title: Text(''),
//                         insetPadding:
//                             EdgeInsets.symmetric(vertical: 200, horizontal: 50),
//                         content: Column(children: [Text("")]),
//                       );
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return alert;
//                         },
//                       );
//                     },
//                   )),
//               Card(
//                 elevation: 6.0,
//                 child: ListTile(
//                   title: Text('NATIONAL FRENCH WEEK - Crêpe Extravaganza!'),
//                   subtitle: Text('October 31st, 4-5pm'),
//                   onTap: () {
//                     AlertDialog alert = AlertDialog(
//                       title: Text('NATIONAL FRENCH WEEK - Crêpe Extravaganza!'),
//                       insetPadding:
//                           EdgeInsets.symmetric(vertical: 200, horizontal: 50),
//                       content: Column(children: [
//                         Text(
//                             "Come out to the SLTC Kitchen today from 4-5 p.m. and help kick off National French Week at our Crêpe extravaganza! All are welcome! Be sure to check out all of the festivities planned this week.")
//                       ]),
//                     );
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return alert;
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ));
//   }
// }
