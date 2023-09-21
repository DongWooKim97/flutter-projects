import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static Map<String, Color> depthColors = {
    'LANDA': Colors.blue,
    'DEPVS': Colors.green,
    'DEPMS': Colors.purple,
    'DEPMD': Colors.yellow,
    'LAN2DA': Colors.blue,
    'DEP11VS': Colors.green,
    'DEPM2S': Colors.purple,
    'DEPM1D': Colors.yellow,
    'LA6N2DA': Colors.blue,
    'DE1P4VS': Colors.green,
    'DEP5MS': Colors.purple,
    'DE1PMD': Colors.yellow,
    '1LANDA': Colors.blue,
    'D2EPVS': Colors.green,
    'D3EPMS': Colors.purple,
    'DEP4MD': Colors.yellow,
    'LAN52DA': Colors.blue,
    'DEP161VS': Colors.green,
    'DEPM782S': Colors.purple,
    'DEPM19D': Colors.yellow,
    'LA6N290DA': Colors.blue,
    'DE1P4V123S': Colors.green,
    'DEP5M512S': Colors.purple,
    'DE1PMD2': Colors.yellow,
  };

  final List<bool> _colorPickerVisibleList =
      List.filled(depthColors.length, false);

  void _show(int index) {
    setState(() {
      _colorPickerVisibleList[index] = true;
    });
  }

  void _hide(int index) {
    setState(() {
      _colorPickerVisibleList[index] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(2.0)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(border: Border.all(width: 1.0)),
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: depthColors.length,
                      itemBuilder: (context, index) {
                        String depthKey = depthColors.keys.elementAt(index);
                        Color? depthValue = depthColors[depthKey];
                        return renderDepthItem(depthKey, depthValue!, index);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderDepthItem(String depthKey, Color depthValue, int index) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 32.0, right: 32.0, bottom: 32.0, top: 32.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              depthKey,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 20.0),
            ElevatedButton(
              onPressed: () {
                _colorPickerVisibleList[index] ? _hide(index) : _show(index);
              },
              style: ElevatedButton.styleFrom(backgroundColor: depthValue),
              child: Visibility(
                visible: _colorPickerVisibleList[index],
                child: _DepthColorPicker(
                  selectedColor: depthValue,
                  onColorChanged: (color) {
                    updateColor(depthKey, color);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateColor(String depthKey, Color newColor) {
    setState(() {
      depthColors[depthKey] = newColor;
    });
  }
}

class _DepthColorPicker extends StatelessWidget {
  final Color selectedColor;
  final ValueChanged<Color> onColorChanged;

  const _DepthColorPicker({
    required this.selectedColor,
    required this.onColorChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ColorPicker(
        colorPickerWidth: 100,
        labelTypes: const [ColorLabelType.rgb],
        paletteType: PaletteType.hueWheel,
        pickerAreaHeightPercent: 0.8,
        pickerColor: selectedColor,
        enableAlpha: true,
        onColorChanged: onColorChanged,
      ),
    );
  }
}
