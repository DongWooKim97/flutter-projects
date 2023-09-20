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
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              child: SingleChildScrollView(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: depthColors.length,
                  itemBuilder: (context, index) {
                    final depthKey = depthColors.keys.elementAt(index);
                    final depthValue = depthColors[depthKey];
                    return renderDepthItem(depthKey, depthValue!);
                  },
                ),
              ),
            ),
            const SizedBox(height: 100),
            const Divider(
              color: Colors.black,
              thickness: 1.0,
            ),
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
            onPressed: _DepthColorPicker(colorPickerVisible: _colorPickerVisible),
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

class _DepthColorPicker extends StatefulWidget {
  final bool colorPickerVisible;

  const _DepthColorPicker({required this.colorPickerVisible, super.key});

  @override
  State<_DepthColorPicker> createState() => _DepthColorPickerState();
}

class _DepthColorPickerState extends State<_DepthColorPicker> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: true,
      child: SingleChildScrollView(
        child: ColorPicker(
          colorPickerWidth: MediaQuery.of(context).size.width / 12.5,
          labelTypes: const [ColorLabelType.rgb],
          paletteType: PaletteType.hsvWithHue,
          pickerAreaHeightPercent: 1.2,
          pickerColor: Colors.black,
          enableAlpha: true,
          onColorChanged: (color) {
            print('헬로');
          },
        ),
      ),
    );
  }
}



/*

ElevatedButton(
            onPressed: () => {!_colorPickerVisible ? _show() : _hide()},
            style: ElevatedButton.styleFrom(
              backgroundColor: depthValue,
            ),
            child: null,
          ),
 */