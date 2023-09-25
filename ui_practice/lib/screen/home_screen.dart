import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../constant/depth_color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<_DepthItemState> _depthItemStates =
      List.generate(depthColors.length, (_) => _DepthItemState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.blue,
          ),
          Container(


            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9), // 투명도 설정
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(2.0),
            ),
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
                            return _DepthItem(
                              depthKey: depthKey,
                              depthValue: depthValue!,
                              state: _depthItemStates[index],
                              onColorChanged: (color) {
                                updateColor(depthKey, color);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void updateColor(String depthKey, Color newColor) {
    setState(() {
      depthColors[depthKey] = newColor;
      print(newColor.value.toRadixString(16).substring(2).toUpperCase());
    });
  }
}

class _DepthItemState {
  bool isColorPickerVisible = false;
  Color currentColor = Colors.transparent;
}

class _DepthItem extends StatelessWidget {
  final String depthKey;
  final Color depthValue;
  final _DepthItemState state;
  final ValueChanged<Color> onColorChanged;

  const _DepthItem({
    required this.depthKey,
    required this.depthValue,
    required this.state,
    required this.onColorChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 32.0,
        right: 32.0,
        bottom: 32.0,
        top: 32.0,
      ),
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
                state.isColorPickerVisible = !state.isColorPickerVisible;
                state.currentColor = depthValue;
                if (state.isColorPickerVisible) {
                  _showColorPicker(context);
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: depthValue),
              child: null,
            ),
          ],
        ),
      ),
    );
  }

  void _showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Select Color for $depthKey'),
          content: SingleChildScrollView(
            child: ColorPicker(
              colorPickerWidth: 300,
              pickerColor: state.currentColor,
              onColorChanged: (color) => {state.currentColor = color},
              enableAlpha: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                onColorChanged(state.currentColor);
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.check),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.close),
            ),
          ],
        );
      },
    );
  }
}
