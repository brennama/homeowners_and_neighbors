import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

//steps to complete problem
//write data to file and read data from that file
//parse data so we can run calculations on it
//calculate dot product
//use dot product to assign a fit score for each person to each neighborhood
//sort everyone into the neighhoods that are the closest match
//make sure there is an equal number of people for each neighborhood

//issues to solve
//unsure of how neighborhood preference is weighted in the assignment of neighborhoods
//maybe can use sample input and output to deduce the exact sorting parameters

void main() {
  runApp(
    MaterialApp(
      title: 'Homeowners and Neighbors',
      home: HomeownersApp(storage: DataStorage()),
    ),
  );
}

class DataStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.txt');
  }

  Future<String> readData() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return '';
    }
  }

  Future<File> writeData(String data) async {
    final file = await _localFile;
    return file.writeAsString(data);
  }
}

class HomeownersApp extends StatefulWidget {
  const HomeownersApp({Key? key, required this.storage}) : super(key: key);

  final DataStorage storage;

  @override
  State<HomeownersApp> createState() => _HomeownersAppState();
}

class _HomeownersAppState extends State<HomeownersApp> {
  String _data = '';

  @override
  void initState() {
    super.initState();
    widget.storage.readData().then((value) {
      setState(() {
        _data = value;
      });
    });
  }

  Future<File> _saveData(String newData) {
    setState(() {
      _data = newData;
    });

    return widget.storage.writeData(newData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reading and Writing Files'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Data from file: $_data',
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    String enteredData = '';
                    return AlertDialog(
                      title: const Text('Edit Data'),
                      content: TextField(
                        onChanged: (value) {
                          enteredData = value;
                        },
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _saveData(enteredData);
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Edit Data'),
            ),
          ],
        ),
      ),
    );
  }
}
