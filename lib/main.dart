import 'package:flutter/material.dart';
import 'dart:io';
import 'data_storage.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Homeowners and Neighbors',
      home: HomeownersApp(storage: DataStorage()),
    ),
  );
}

class HomeownersApp extends StatefulWidget {
  const HomeownersApp({Key? key, required this.storage}) : super(key: key);

  final DataStorage storage;

  @override
  State<HomeownersApp> createState() => _HomeownersAppState();
}

class _HomeownersAppState extends State<HomeownersApp> {
  final TextEditingController _textEditingController = TextEditingController();
  String _data = '';

  @override
  void initState() {
    super.initState();
    widget.storage.readData().then((value) {
      setState(() {
        _data = value;
        _textEditingController.text =
            _data;
      });
    });
  }

  Future<File> _saveData(String newData) async {
    setState(() {
      _data = newData;
    });

    return widget.storage
        .writeData(newData);
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
                    return AlertDialog(
                      title: const Text('Edit Data'),
                      content: TextField(
                        controller:
                            _textEditingController,
                        onChanged: (value) {
                        },
                        maxLines: null,
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _saveData(_textEditingController
                                .text); /
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
