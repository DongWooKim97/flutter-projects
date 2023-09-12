import 'package:flutter/material.dart';
import 'package:random_number_generator/constant/color.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double maxNumber = 10000;

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
              Expanded(
                child: Row(
                  children: maxNumber
                      .toInt()
                      .toString()
                      .split('')
                      .map(
                        (e) => Image.asset(
                          'asset/img/$e.png',
                          width: 50.0,
                          height: 70.0,
                        ),
                      )
                      .toList(),
                ),
              ),
              Slider(
                // 슬라이더자체는 동그라미를 움직일때 그 동작을 그려내는 것을 못하므로 우리가 따로 선언 및 어떤 동작을 해줘야한다.
                // 그렇다면 어떠한 값으로 빌드가 되느냐 ? 우리가 설정한 value : maxValue로 설정해줬기 때문에 maxValue값으로 변경이 된다.
                value: maxNumber,
                min: 10000,
                max: 1000000,
                onChanged: (double val) {
                  setState(() {
                    maxNumber = val;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: RED_COLOR,
                ),
                child: Text('저장!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
