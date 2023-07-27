import 'package:flutter/material.dart';
import 'data/data_storage.dart';
import 'package:homeowners_and_neighborhoods/data/sort.dart';
import 'package:homeowners_and_neighborhoods/data/parse_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DataStorage dataStorage = DataStorage();

  // Read the input data from input.txt using the DataStorage class
  String inputData = await dataStorage.readInput();

  // Call the printDotProducts function with the inputData
  printDotProducts(inputData);

  runApp(
    MaterialApp(
      title: 'Homeowners and Neighbors',
      home: HomeownersApp(
        storage: dataStorage,
      ),
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
  String _inputData = '';
  String _outputData = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // Use _inputData from printDotProducts instead of reading input data from input.txt
    String inputData = await widget.storage.readInput();
    _inputData = printDotProducts(inputData);

    _textEditingController.text = _inputData;

    // Calculate the output data
    double maxHomeowners = 12 / 3;
    _outputData = assignHomeowners(_inputData, maxHomeowners);

    setState(() {}); // Trigger a rebuild to update the displayed text
  }

  Future<void> _saveData(String newData) async {
    setState(() {
      _inputData = newData;
    });

    // Write the updated data to input.txt
    await widget.storage.writeInput(newData);

    // Calculate the new output data with the updated input
    double maxHomeowners = 12 / 3;
    _outputData = assignHomeowners(newData, maxHomeowners);

    // Write the new output data to output.txt
    await widget.storage.writeOutput(_outputData);

    // Reload the data to ensure the output is updated based on the new input
    await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homeowners and Neighbors'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 500,
                child: SingleChildScrollView(
                  child: Text(
                    'Dot product scores: \n$_inputData',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Output data: $_outputData',
              ),
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
                        onChanged: (value) {
                          _inputData = value;
                        },
                        maxLines: null,
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _saveData(_inputData);
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
