import 'package:flutter/material.dart';
import 'package:random_number_generator/component/number_row.dart';
import 'package:random_number_generator/constant/color.dart';

class SettingsScreen extends StatefulWidget {
  final int maxNumber;

  const SettingsScreen({
    required this.maxNumber,
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double maxNumber = 1000; // State에다가 직접 선언하는 변수에다가는 Widget이라는 키워드를 사용할 수 없음.

  @override
  void initState() {
    // State클래스가 생성되는 순간 initState가 실행됨.
    // build함수가 실행되기 전에 실행됨
    // TODO: implement initState
    super.initState();
    maxNumber = widget.maxNumber.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Body(maxNumber: maxNumber),
              _Footer(
                maxNumber: maxNumber,
                onSliderChanged: onSliderChanged,
                onButtonPressed: onButtonPressed,
              )
            ],
          ),
        ),
      ),
    );
  }

  void onSliderChanged(double val) {
    setState(() {
      maxNumber = val;
    });
  }

  void onButtonPressed() {
    // 현재 화면을 터트린다 -> 뒤로 돌린다. 세팅 페이지에서 설정한 maxNumber를 홈화면에 전달해줘야한다.
    // [ T? result] -> Optional 파라미터를 통해 넘기는 값이 result라는 파라미터이다.
    Navigator.of(context).pop(maxNumber.toInt());
  }
}

class _Body extends StatelessWidget {
  final double maxNumber;

  const _Body({
    required this.maxNumber,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NumberRow(number: maxNumber.toInt()),
    );
  }
}

class _Footer extends StatelessWidget {
  final double maxNumber;
  final ValueChanged<double>? onSliderChanged;
  final VoidCallback onButtonPressed;

  const _Footer({
    required this.maxNumber,
    required this.onSliderChanged,
    required this.onButtonPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 리턴은 당연하게도 하나밖에 안되는데 Footer 클래스에 2개의 위젯을 묶었기때문에 Column위젯으로 묶어서 리턴
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Slider(
          // 슬라이더자체는 동그라미를 움직일때 그 동작을 그려내는 것을 못하므로 우리가 따로 선언 및 어떤 동작을 해줘야한다.
          // 그렇다면 어떠한 값으로 빌드가 되느냐 ? 우리가 설정한 value : maxValue로 설정해줬기 때문에 maxValue값으로 변경이 된다.
          value: maxNumber,
          min: 1000,
          max: 100000,
          onChanged: onSliderChanged,
        ),
        ElevatedButton(
          onPressed: onButtonPressed,
          style: ElevatedButton.styleFrom(
            primary: RED_COLOR,
          ),
          child: Text('저장!'),
        ),
      ],
    );
  }
}
