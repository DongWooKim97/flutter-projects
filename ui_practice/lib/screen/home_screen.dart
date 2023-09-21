import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool colorPickerVisible = false;
  static final Map<String, Color> depthColors = {
    'LANDA': Colors.blue,
    'DEPVS': Colors.green,
    'DEPMS': Colors.purple,
    'DEPMD': Colors.yellow,
    'DEPDW': Colors.grey,
  };

  void updateColor(String key, Color newColor) {
    setState(() {
      depthColors[key] = newColor;
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
              child: Column(
                children: depthColors.entries.map(
                  (colors) {
                    return _DepthColorPicker(
                      title: colors.key,
                      color: colors.value,
                      updateColor: updateColor,
                    );
                  },
                ).toList(),
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
}

class _DepthColorPicker extends StatefulWidget {
  final String title;
  final Color color;
  final Function(String, Color) updateColor;

  const _DepthColorPicker({
    required this.title,
    required this.color,
    required this.updateColor,
    Key? key,
  }) : super(key: key);

  @override
  State<_DepthColorPicker> createState() => _DepthColorPickerState();
}

class _DepthColorPickerState extends State<_DepthColorPicker> {
  bool colorPickerVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 32.0, right: 32.0, bottom: 16.0, top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 20.0),
          ElevatedButton(
            onPressed: () {
              if (!colorPickerVisible) {
                setState(() {
                  colorPickerVisible = true;
                });
              } else {
                setState(() {
                  colorPickerVisible = false;
                });
              }
              renderColorPicker(!colorPickerVisible);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.color,
            ),
            child: null,
          ),
        ],
      ),
    );
  }

  Widget renderColorPicker(bool isVisible) {
    return Visibility(
      visible: isVisible,
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

/*

                  // child: ListView.builder(
                  //   scrollDirection: Axis.vertical,
                  //   shrinkWrap: true,
                  //   itemCount: depthColors.length,
                  //   itemBuilder: (context, index) {
                  //     final depthKey = depthColors.keys.elementAt(index);
                  //     final depthValue = depthColors[depthKey];
                  //     return renderDepthItem(depthKey, depthValue!);
                  //   },
                  // ),
 */

/*
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
 */

/*
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
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: depthValue,
            ),
            child: null,
          ),
        ],
      ),
    );
  }
 */
