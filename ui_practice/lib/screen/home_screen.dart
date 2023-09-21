import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static final Map<String, Color> depthColors = {
    'LANDA': Colors.blue,
    'DEPVS': Colors.green,
    'DEPMS': Colors.purple,
    'DEPMD': Colors.yellow,
    'DEPDW': Colors.grey,
  };
  bool _colorPickerVisible = false;

  void _toggleColorPicker() {
    setState(() {
      _colorPickerVisible = !_colorPickerVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 300,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: Column(
          children: [
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: depthColors.length,
              itemBuilder: (context, index) {
                final depthKey = depthColors.keys.elementAt(index);
                final depthValue = depthColors[depthKey];
                return renderDepthItem(depthKey, depthValue!);
              },
            ),
            const SizedBox(height: 300),
            if (_colorPickerVisible)
              ColorPicker(
                pickerColor: Colors.black,
                onColorChanged: (color) {
                  print('헬로');
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget renderDepthItem(String depthKey, Color depthValue) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(depthKey),
          const SizedBox(width: 20.0),
          ElevatedButton(
            onPressed: _toggleColorPicker,
            style: ElevatedButton.styleFrom(
              backgroundColor: depthValue,
            ),
            child: null,
          ),
        ],
      ),
    );
  }
}
