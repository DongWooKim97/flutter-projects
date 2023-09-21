import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static Map<String, Color> depthColors = {
    'LANDA': Colors.blue,
    'DEPVS': Colors.green,
    'DEPMS': Colors.purple,
    'DEPMD': Colors.yellow,
    'DEPDW': Colors.grey,
    '1DEPDW': Colors.grey,
    '2DEPDW': Colors.grey,
    '3DEPDW': Colors.grey,
    '4DEPDW': Colors.grey,
    '41DEPDW': Colors.grey,
    '42DEPDW': Colors.grey,
    '43DEPDW': Colors.grey,
    '44DEPDW': Colors.grey,
    '4%DEPDW': Colors.grey,
    '46DEPDW': Colors.grey,
    '45DEPDW': Colors.grey,
  };
  bool _colorPickerVisible = false;

  void _show() {
    setState(() {
      _colorPickerVisible = true;
    });
  }

  void _hide() {
    setState(() {
      _colorPickerVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width / 4,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(2.0)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(border: Border.all(width: 1.0)),
                height: MediaQuery.of(context).size.height / 3,
                child: SingleChildScrollView(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: depthColors.length,
                    itemBuilder: (context, index) {
                      String depthKey = depthColors.keys.elementAt(index);
                      Color? depthValue = depthColors[depthKey];
                      return renderDepthItem(depthKey, depthValue!);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    print('저장');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(80, 40),
                  ),
                  child: const Text('저장'),
                ),
                ElevatedButton(
                  onPressed: () {
                    print('닫기');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(80, 40),
                  ),
                  child: Text('닫기'),
                ),
              ],
            ),
            const Divider(color: Colors.black),
            if (_colorPickerVisible)
              Visibility(visible: true, child: _DepthColorPicker(selectedColor: Colors.red,)),
          ],
        ),
      ),
    );
  }

  Widget renderDepthItem(String depthKey, Color depthValue) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 32.0, right: 32.0, bottom: 16.0, top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            onPressed: () => {!_colorPickerVisible ? _show() : _hide()},
            style: ElevatedButton.styleFrom(backgroundColor: depthValue),
            child: null,
          ),
        ],
      ),
    );
  }
}

class _DepthColorPicker extends StatefulWidget {
  final Color selectedColor;

  const _DepthColorPicker({required this.selectedColor, super.key});

  @override
  State<_DepthColorPicker> createState() => _DepthColorPickerState();
}

class _DepthColorPickerState extends State<_DepthColorPicker> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ColorPicker(
        colorPickerWidth: MediaQuery.of(context).size.width / 12.5,
        labelTypes: const [ColorLabelType.rgb],
        paletteType: PaletteType.hsvWithHue,
        pickerAreaHeightPercent: 1.2,
        pickerColor: widget.selectedColor,
        enableAlpha: true,
        onColorChanged: (color) {
          setState(() {

          });
        },
      ),
    );
  }
}
