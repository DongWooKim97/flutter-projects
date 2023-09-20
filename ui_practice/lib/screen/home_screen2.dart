import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(const MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<String, Color> depthColors = {
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
      appBar: AppBar(
        title: Text('Depth Colors'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: depthColors.entries.map((colors) {
            return DepthColorItem(
              title: colors.key,
              color: colors.value,
              updateColor: updateColor,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class DepthColorItem extends StatefulWidget {
  final String title;
  final Color color;
  final Function(String, Color) updateColor;

  const DepthColorItem({
    required this.title,
    required this.color,
    required this.updateColor,
    Key? key,
  }) : super(key: key);

  @override
  _DepthColorItemState createState() => _DepthColorItemState();
}

class _DepthColorItemState extends State<DepthColorItem> {
  Color selectedColor = Colors.blue;

  void openColorPickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a Color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
                setState(() {
                  selectedColor = color;
                });
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.5,
              // pickerAreaWidthPercent: 0.5,
              enableAlpha: true,
              paletteType: PaletteType.hsvWithHue,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('닫기'),
              onPressed: () {
                widget.updateColor(widget.title, selectedColor); // 업데이트 함수 호출

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              selectedColor = widget.color;
            });
            openColorPickerDialog(context);
          },
          child: Container(
            width: 50,
            height: 50,
            color: selectedColor,
          ),
        ),
      ],
    );
  }
}
