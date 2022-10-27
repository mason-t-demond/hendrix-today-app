import 'package:flutter/material.dart';

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
  final List<Widget> pages = [MyHomeScreen(), TBDScreen()];
  final List<String> titles = ["Homes", "TBD"];
  final Color webOrange = Color.fromARGB(255, 202, 81, 39);

  @override
  void initState() {
    super.initState();
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 202, 81, 39),
            title: Text(titles[selectedIndex])),
        body: Center(child: pages[selectedIndex]),
        bottomNavigationBar:
            BottomNavigationBar(items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Color.fromARGB(255, 202, 81, 39),
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.tab,
                color: webOrange,
              ),
              label: "TBD")
        ], currentIndex: selectedIndex, onTap: onItemTapped));
  }
}

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Center(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Event Title'),
            onTap: () {
              AlertDialog alert = AlertDialog(
                title: Text('Event Here'),
                content: Column(
                  children: [
                    Text("Event description here")
                  ]),
              );
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            },
          )
        ],
      ),
    );
  }
}

class TBDScreen extends StatefulWidget {
  const TBDScreen({super.key});

  @override
  State<TBDScreen> createState() => _TBDScreenState();
}

class _TBDScreenState extends State<TBDScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Hello World'),
    );
  }
}
