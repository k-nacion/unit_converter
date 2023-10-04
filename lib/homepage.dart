import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textInput = TextEditingController();
  String? _textOutput;
  late String _fromDropdownValue;
  late String _toDropdownValue;

  final List<String> _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds (lbs)',
    'ounces',
  ];

  final Map<String, int> _measuresMap = {
    'meters': 0,
    'kilometers': 1,
    'grams': 2,
    'kilograms': 3,
    'feet': 4,
    'miles': 5,
    'pounds (lbs)': 6,
    'ounces': 7,
  };

  final Map<int, List<num>> _formulas = {
    0: [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    1: [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    2: [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
    3: [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    4: [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    5: [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    6: [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    7: [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
  };

  TextStyle? get $titleTextStyle =>
      Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.grey[600]);

  double convert({double? value = 0, required String from, required String to}) {
    final nFrom = _measuresMap[from];
    final nTo = _measuresMap[to];
    final multiplier = _formulas[nFrom]![nTo!];
    return value! * multiplier;
  }

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
                Text('Value', style: $titleTextStyle),
                const SizedBox(height: 12),
                TextField(
                  controller: _textInput,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Please insert the measure to be...',
                  ),
                  /*onChanged: (value) {
                    final rv = double.tryParse(value);
                    final numberFormatter = NumberFormat('#.#', 'en-us');

                    if (rv != null) {
                      setState(() {
                        _textOutput = numberFormatter.format(rv);
                      });
                    }
                  },*/
                ),
                const SizedBox(height: 12),
                Text('From', style: $titleTextStyle),
                const SizedBox(height: 12),
                DropdownMenu<String>(
                    initialSelection: _fromDropdownValue,
                    dropdownMenuEntries: _measures.map((e) {
                      return DropdownMenuEntry<String>(value: e, label: e);
                    }).toList()),
                const SizedBox(height: 12),
                Text('To', style: $titleTextStyle),
                const SizedBox(height: 12),
                DropdownMenu<String>(
                  menuStyle: MenuStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    minimumSize: const MaterialStatePropertyAll<Size>(Size.infinite),
                  ),
                  initialSelection: _toDropdownValue,
                  dropdownMenuEntries: _measures.map(
                    (e) {
                      return DropdownMenuEntry<String>(value: e, label: e);
                    },
                  ).toList(),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: processConvert,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                  ),
                  child: const Text(
                    'Convert',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 12),
                if (_textOutput != null)
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

  void processConvert() {
    final double? value = double.tryParse(_textInput.text);
    final numberFormatter = NumberFormat('#.############', 'en-us');
    final convertedValue = convert(value: value, from: _fromDropdownValue, to: _toDropdownValue);
    setState(() {
      _textOutput = numberFormatter.format(convertedValue);
    });
  }
}
