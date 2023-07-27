import 'dart:io';
import 'package:flutter/material.dart';
import 'data/data_storage.dart';
import 'package:homeowners_and_neighborhoods/data/sort.dart';

void main() async {
  runApp(
    MaterialApp(
      title: 'Homeowners and Neighbors',
      home: HomeownersApp(storage: DataStorage()),
    ),
  );

  String input = """
    Dot Product for N0 and H6 188 N2>N1>N0
Dot Product for N0 and H3 171 N2>N0>N1
Dot Product for N0 and H5 161 N0>N2>N1
Dot Product for N0 and H11 154 N0>N1>N2
Dot Product for N0 and H2 128 N0>N2>N1
Dot Product for N2 and H6 128 N2>N1>N0
Dot Product for N0 and H4 122 N0>N2>N1
Dot Product for N2 and H3 120 N2>N0>N1
Dot Product for N0 and H10 120 N0>N2>N1
Dot Product for N0 and H1 119 N0>N2>N1
Dot Product for N2 and H5 112 N0>N2>N1
Dot Product for N2 and H11 108 N0>N1>N2
Dot Product for N0 and H7 106 N2>N1>N0
Dot Product for N2 and H4 106 N0>N2>N1
Dot Product for N0 and H0 104 N2>N0>N1
Dot Product for N0 and H8 100 N1>N0>N2
Dot Product for N0 and H9 94 N1>N2>N0
Dot Product for N2 and H9 86 N1>N2>N0
Dot Product for N2 and H10 86 N0>N2>N1
Dot Product for N2 and H0 83 N2>N0>N1
Dot Product for N2 and H8 80 N1>N0>N2
Dot Product for N2 and H7 75 N2>N1>N0
Dot Product for N2 and H1 74 N0>N2>N1
Dot Product for N2 and H2 68 N0>N2>N1
Dot Product for N1 and H6 31 N2>N1>N0
Dot Product for N1 and H3 31 N2>N0>N1
Dot Product for N1 and H11 27 N0>N1>N2
Dot Product for N1 and H5 26 N0>N2>N1
Dot Product for N1 and H4 23 N0>N2>N1
Dot Product for N1 and H9 23 N1>N2>N0
Dot Product for N1 and H8 21 N1>N0>N2
Dot Product for N1 and H10 21 N0>N2>N1
Dot Product for N1 and H7 20 N2>N1>N0
Dot Product for N1 and H1 18 N0>N2>N1
Dot Product for N1 and H2 18 N0>N2>N1
Dot Product for N1 and H0 17 N2>N0>N1
  """;

  double maxHomeowners = 12 / 3;

  String output = assignHomeowners(input, maxHomeowners);

  DataStorage dataStorage = DataStorage();
  await dataStorage.writeInput(input);
  await dataStorage.writeOutput(output);
}

class HomeownersApp extends StatefulWidget {
  const HomeownersApp({Key? key, required this.storage}) : super(key: key);

  final DataStorage storage;

  @override
  State<HomeownersApp> createState() => _HomeownersAppState();
}

class _HomeownersAppState extends State<HomeownersApp> {
  final TextEditingController _textEditingController = TextEditingController();
  String _inputData = '';
  String _outputData = '';

  @override
  void initState() {
    super.initState();
    widget.storage.readInput().then((value) {
      setState(() {
        _inputData = value;
        _textEditingController.text = _inputData;
      });
    });

    // Read output data
    widget.storage.readOutput().then((value) {
      setState(() {
        _outputData = value;
      });
    });
  }

  Future<File> _saveData(String newData) async {
    setState(() {
      _inputData = newData;
    });

    return widget.storage.writeInput(newData);
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
            Row(
              children: [
                Text(
                  'Input data: $_inputData',
                ),
                Text(
                  'Output data: $_outputData',
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Edit Data'),
                      content: TextField(
                        controller: _textEditingController,
                        onChanged: (value) {},
                        maxLines: null,
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _saveData(_textEditingController.text);
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
