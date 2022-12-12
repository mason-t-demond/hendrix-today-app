// a lot of code was written with the help of this video: https://www.youtube.com/watch?v=pUV5v240po0&ab_channel=dbestech
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async'; // new
import 'firebase.dart' as fb; //

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

//search screen needs search bar
//Search bar requires keyboard access and related stuff
//search needs to display relevant events in ToDoList/listTile form
class _SearchScreenState extends State<SearchScreen> {
  Color webOrange = const Color.fromARGB(255, 202, 81, 39);
  TextEditingController textController = TextEditingController();
  final Stream<QuerySnapshot> _usersStream =
      fb.db.collection('eventsListed').snapshots();
  List<String> events = [];
  List<String> searchedEvents = [];

  @override
  initState() {
    searchedEvents = events;
    super.initState();
  }

  void runFilter(String query) {
    List<String> results = [];
    if (query.isEmpty) {
      results = events;
    } else {
      for (String event in events) {
        if (event.toLowerCase().contains(query.toLowerCase())) {
          results.add(event);
        }
      }
    }

    setState(() {
      searchedEvents = results;
    });
  }

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

        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ListView(
            key: const Key('daily_events_list'),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) => runFilter(value),
                  decoration: const InputDecoration(
                      labelText: 'Enter search query',
                      suffixIcon: Icon(Icons.search)),
                ),
              ),
              ListBody(
                  //pulls data (events) from snapshot and converts to map
                  //then converts to list
                  //then converts to card
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return Card(
                            elevation: 6.0,
                            child: ListTile(
                              title: Text(data["title"]),
                              subtitle: Text(data["date"]),
                              onTap: () {
                                AlertDialog alert = AlertDialog(
                                  title: Text(data["title"]),
                                  insetPadding: EdgeInsets.symmetric(
                                      vertical: 200, horizontal: 50),
                                  content:
                                      Column(children: [Text(data["desc"])]),
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
