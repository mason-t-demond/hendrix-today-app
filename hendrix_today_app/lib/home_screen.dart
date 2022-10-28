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
            title: Text(''),
            onTap: () {
              AlertDialog alert = AlertDialog(
                title: Text('Literature and Language over Lunch'),
                content: Column(children: [Text("With Mel White, '72 in the Murphy Seminar Room from 12pm-1pm")]),
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
            title: Text('Ghost Roast'),
            onTap: () {
              AlertDialog alert = AlertDialog(
                title: Text('Ghost Roast'),
                content: Column(
                  children: [
                    Text("Takes place in Worsham from 10pm to 1am, the SLTC entrance facing Couch will be used.")]),
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
