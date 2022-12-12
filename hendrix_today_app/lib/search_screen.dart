// a lot of code was written with the help of this video: https://www.youtube.com/watch?v=pUV5v240po0&ab_channel=dbestech
import 'package:flutter/material.dart';

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
  List<String> events = [
    'Sword Club',
    'Ask Mason a Question Day',
    'Sarah Appreciation Day',
    'Perceive Olivia Day',
    'Is ET an Alien?',
    'Fry Friday',
    "Eat at Arby's",
    "DO NOT PRESS THE RED BUTTON",
    'No Sleeve Day',
    'HDX Secret Cult Meeting'
  ];
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: TextField(
              onChanged: (value) => runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Enter search query',
                  suffixIcon: Icon(Icons.search)),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: searchedEvents.length,
                itemBuilder: (context, index) => Card(
                    elevation: 6.0,
                    margin: const EdgeInsets.symmetric(vertical: 2.5),
                    child: ListTile(title: Text(searchedEvents[index])))),
          ),
        ],
      ),
    );
  }
}
