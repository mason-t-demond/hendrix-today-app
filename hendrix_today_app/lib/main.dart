import 'package:flutter/material.dart';
import 'package:hendrix_today_app/home_screen.dart';
import 'package:hendrix_today_app/calendar_screen.dart';
import 'package:hendrix_today_app/search_screen.dart';
import 'package:hendrix_today_app/firebase_options.dart';
import 'dart:async';                                     // new
import 'package:firebase_auth/firebase_auth.dart'        // new
    hide EmailAuthProvider, PhoneAuthProvider;           // new
import 'package:firebase_core/firebase_core.dart';       // new
import 'package:firebase_ui_auth/firebase_ui_auth.dart'; // new
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';                 // new

import 'firebase_options.dart';                          // new
//import 'src/authentication.dart';                        // new
//import 'src/widgets.dart';


void main() {
  runApp(const MaterialApp(home: ScreenContainer()));
}

class ScreenContainer extends StatefulWidget {
  const ScreenContainer({super.key});

  @override
  State<ScreenContainer> createState() => _ScreenContainerState();
}

class _ScreenContainerState extends State<ScreenContainer> {
  int selectedIndex = 0;
  List<Widget> pages = []; //contains each page
  List<String> titles = []; //contains the title of each page

  @override
  void initState() {
    super.initState();
    pages = [
      const MyHomeScreen(),
      const CalendarScreen(),
      const SearchScreen()
    ]; //Stores Pages for BottomNav
    titles = [
      "Hendrix Today",
      "HDX Calendar",
      "Search"
    ]; //Stores Page Titles for AppBar
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color webOrange = const Color.fromARGB(255, 202, 81, 39);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: webOrange, title: Text(titles[selectedIndex])),
        body: Center(child: pages[selectedIndex]),
        bottomNavigationBar:
            BottomNavigationBar(items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: webOrange,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_month_outlined,
                color: webOrange,
              ),
              label: "Calendar"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: webOrange,
              ),
              label: "Search")
        ], currentIndex: selectedIndex, onTap: onItemTapped));
  }
}
class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
      } else {
        _loggedIn = false;
      }
      notifyListeners();
    });
  }
}
