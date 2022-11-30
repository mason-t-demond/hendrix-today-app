import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//I found the search bar here: https://pub.dev/packages/anim_search_bar/example
import 'package:anim_search_bar/anim_search_bar.dart';
import 'main.dart';
import 'event.dart';
import 'event_items.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //padding: const EdgeInsets.only(right: 10, left: 10),

      /// In AnimSearchBar widget, the width, textController, onSuffixTap are required properties.
      /// You have also control over the suffixIcon, prefixIcon, helpText and animationDurationInMilli
      body: AnimSearchBar(
        width: 400,
        textController: textController,
        onSuffixTap: () {
          setState(() {
            textController.clear();
          });
        },
      ),
    );
  }
}
