import 'package:flutter/material.dart';

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
            title: Text('Farewell to Dean Wiltgen'),
            onTap: () {
              AlertDialog alert = AlertDialog(
                title: Text('Farewell to Dean Wiltgen'),
                content: Column(children: [
                  Text(
                      "You are invited to drop by the SLTC Student Services Suite today from 2-4 p.m. to say farewell to Dean Wiltgen. There will be refreshments while they last!")
                ]),
              );
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            },
          ),
          ListTile(
            title: Text('NATIONAL FRENCH WEEK - Crêpe Extravaganza!'),
            onTap: () {
              AlertDialog alert = AlertDialog(
                title: Text('NATIONAL FRENCH WEEK - Crêpe Extravaganza!'),
                content: Column(children: [
                  Text(
                      "Come out to the SLTC Kitchen today from 4-5 p.m. and help kick off National French Week at our Crêpe extravaganza! All are welcome! Be sure to check out all of the festivities planned this week.")
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
