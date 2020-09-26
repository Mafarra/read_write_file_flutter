import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(new MaterialApp(
    title: 'IO File System',
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _enterDataField = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IO - Read Write"),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Container(
        padding: const EdgeInsets.all(13.5),
        alignment: Alignment.topCenter,
        child: ListTile(
          title: TextField(
            controller: _enterDataField,
            decoration: InputDecoration(labelText: "Write Something"),
          ),
          subtitle: FlatButton(
            onPressed: () {
              //if statement
              writeData(_enterDataField.text);
            },
            child: Column(
              children: <Widget>[
                Text('Save Data'),
                Padding(
                  padding: EdgeInsets.all(15.0),
                ),
                FutureBuilder(
                  future: readData(),
                  builder: (BuildContext context, AsyncSnapshot<String> data) {
                    if (data.hasData != null) {
                      return Text(
                        data.data.toString(),
                        style: TextStyle(color: Colors.red),
                      );
                    } else {
                      return Text("There is not saved data");
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path; //home/directory/document
}

Future<String> get _llocalpath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _llocalFile async {
  final path = await _llocalpath;
  return File('$path/data.txt');
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/data.txt');
}

Future<File> writeData(String message) async {
  final file = await _localFile;
  return file.writeAsString(message);
}

Future<String> readData() async {
  try {
    final file = await _localFile;
    //read from the file
    String data = await file.readAsString();
    return data;
  } catch (e) {
    return "Nothing saved in the file!";
  }
}
