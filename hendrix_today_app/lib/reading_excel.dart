import 'event.dart';
import 'event_items.dart';
import 'calendar_screen.dart';
import 'search_screen.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'dart:async';

//https://pub.dev/packages/gsheets/install
import 'package:gsheets/gsheets.dart';

/// Your google auth credentials
///
/// how to get credentials - https://medium.com/@a.marenkov/how-to-get-credentials-for-google-sheets-456b7e88c430
const _credentials = r'''
{
  "type": "service_account",
  "project_id": "",
  "private_key_id": "",
  "private_key": "",
  "client_email": "",
  "client_id": "",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": ""
}
''';

/// Your spreadsheet id
///
/// It can be found in the link to your spreadsheet -
/// link looks like so https://docs.google.com/spreadsheets/d/YOUR_SPREADSHEET_ID/edit#gid=0
/// [YOUR_SPREADSHEET_ID] in the path is the id your need
/// https://drive.google.com/file/d/1TYgcaoitANxOjMOduk5iRqTIvebWw2kT/view?pli=1
/// https://docs.google.com/spreadsheets/d/1TYgcaoitANxOjMOduk5iRqTIvebWw2kT/edit?usp=sharing&ouid=100579109515815935973&rtpof=true&sd=true
const _spreadsheetId = '1TYgcaoitANxOjMOduk5iRqTIvebWw2kT';

void fileParsing() async {
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);

  print(ss.data.namedRanges.byName.values
      .map((e) => {
            'name': e.name,
            'start':
                '${String.fromCharCode((e.range?.startColumnIndex ?? 0) + 97)}${(e.range?.startRowIndex ?? 0) + 1}',
            'end':
                '${String.fromCharCode((e.range?.endColumnIndex ?? 0) + 97)}${(e.range?.endRowIndex ?? 0) + 1}'
          })
      .join('\n'));

  // get worksheet by its title
  var sheet = ss.worksheetByTitle('Hendrix Today submission form');

  // get cell at 'B2' as Cell object
  final cell = await sheet!.cells.cell(column: 2, row: 2);
  // prints 'new'
  print(cell.value);

  // get first row as List of Cell objects
  final firstRow = await sheet.cells.row(1);
  print(firstRow);
}

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

//search screen needs search bar
//Search bar requires keyboard access and related stuff
//search needs to display relevant events in ToDoList/listTile form
class _UploadScreenState extends State<UploadScreen> {
  Color webOrange = const Color.fromARGB(255, 202, 81, 39);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //padding: const EdgeInsets.only(right: 10, left: 10),

      /// In AnimSearchBar widget, the width, textController, onSuffixTap are required properties.
      /// You have also control over the suffixIcon, prefixIcon, helpText and animationDurationInMilli
      body: ElevatedButton(
        key: Key('FileUpload'),
        onPressed: () {
          setState(() {
            fileParsing();
          });
        },
        child: const Text('Select a .xlsx file to upload'),
      ),
    );
  }
}
