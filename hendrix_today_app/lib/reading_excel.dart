import 'dart:ffi';
//import 'dart:html';

import 'event.dart';
import 'event_items.dart';
import 'calendar_screen.dart';
import 'search_screen.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'dart:async';

//https://pub.dev/packages/gsheets/install is where I got most of the code
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

Future<List<String>> fileParsing(String input) async {
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

  // get first row as List of Cell objects
  //ie get headers
  final firstRow = await sheet!.cells.row(1);
  print(firstRow);

  // get cell at 'B2' as Cell object
  final cell = await sheet.cells.cell(column: 2, row: 2);
  // prints 'new'
  print(cell.value);

  //get sheet headers
  final headers = await await sheet.cells.row(1);

  //get row values in a specific col
  final getColVals =
      await sheet.cells.column(1, fromRow: 2, length: ss.sheets.length);

  //get titles
  final List<Cell> getTitles =
      await sheet.cells.column(5, fromRow: 2, length: ss.sheets.length);

  //get description
  final List<Cell> getDesc =
      await sheet.cells.column(12, fromRow: 2, length: ss.sheets.length);

  //get event dates
  final List<Cell> getEDates =
      await sheet.cells.column(9, fromRow: 2, length: ss.sheets.length);

  //get item type (event, announcement, etc)
  final List<Cell> getType =
      await sheet.cells.column(8, fromRow: 2, length: ss.sheets.length);

  //loops through list of cells and converts to list of strings
  List<String> cellToString(cellList) {
    List<String> listOfStrings = [];
    for (int i = 0; i < cellList.length; i++) {
      listOfStrings.add(cellList[i].toString());
    }
    return listOfStrings;
  }

  //conglomerate everything into dic
  //keys are header values (String)
  //values are the cells in desired col (List<String>)
  Map<String, dynamic> sheetMap() {
    Map<String, dynamic> eventMap = {};
    for (int i = 0; i < headers.length; i++) {
      if (i == 4 || i == 11 || i == 8 || i == 7) {
        eventMap[headers[i].value] = cellToString(
            sheet.cells.column(i + 1, fromRow: 2, length: ss.sheets.length));
      }
    }
    return eventMap;
  }

  if (input == 'title') {
    return cellToString(getTitles);
  } else if (input == 'date') {
    return cellToString(getEDates);
  } else if (input == 'desc') {
    return cellToString(getDesc);
  } else if (input == 'type') {
    return cellToString(getType);
  } else {
    return [''];
  }
}

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

//upload screen, housed behind FB authentication
//this will house file upload and parsing into events
class _UploadScreenState extends State<UploadScreen> {
  Color webOrange = const Color.fromARGB(255, 202, 81, 39);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //need this button to bring up a dialouge box where they can upload sharable link
      //program will find file id and parse
      body: ElevatedButton(
        key: Key('FileUpload'),
        onPressed: () {
          setState(() {
            //this is incorrect use of this rn
            //needs to be dialouge box to get spreadsheet id
            fileParsing('');
          });
        },
        child: const Text('Select a .xlsx file to upload'),
      ),
    );
  }
}
