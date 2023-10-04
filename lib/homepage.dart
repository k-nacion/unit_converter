import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _textOutput;

  final List<String> _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pound (lbs)',
    'ounces',
  ];
  String? _fromDropdownValue;
  String? _toDropdownValue;

  @override
  void initState() {
    super.initState();
    // Add code after super
    _fromDropdownValue = _measures.first;
    _toDropdownValue = _measures[1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Measures Converter'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 12),
                Text('Value', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 12),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Please insert the measure to be...',
                  ),
                  onChanged: (value) {
                    final rv = double.tryParse(value);
                    final numberFormatter = NumberFormat('#.#', 'en-us');

                    if (rv != null) {
                      setState(() {
                        _textOutput = numberFormatter.format(rv);
                      });
                    }
                  },
                ),
                const SizedBox(height: 12),
                Text('From', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 12),
                DropdownMenu<String>(
                    initialSelection: _fromDropdownValue,
                    dropdownMenuEntries: _measures.map((e) {
                      return DropdownMenuEntry<String>(value: e, label: e);
                    }).toList()),
                const SizedBox(height: 12),
                Text('To', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 12),
                DropdownMenu<String>(
                    initialSelection: _toDropdownValue,
                    dropdownMenuEntries: _measures.map((e) {
                      return DropdownMenuEntry<String>(value: e, label: e);
                    }).toList()),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                  ),
                  child: const Text(
                    'Convert',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _textOutput.toString(),
                  style: Theme.of(context).textTheme.headlineSmall,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
