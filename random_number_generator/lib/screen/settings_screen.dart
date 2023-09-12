import 'package:flutter/material.dart';
import 'package:random_number_generator/constant/color.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double maxNumber = 1000;

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
                min: 1000,
                max: 100000,
                onChanged: (double val) {
                  setState(() {
                    maxNumber = val;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  // 현재 화면을 터트린다 -> 뒤로 돌린다. 세팅 페이지에서 설정한 maxNumber를 홈화면에 전달해줘야한다.
                  // [ T? result] -> Optional 파라미터를 통해 넘기는 값이 result라는 파라미터이다.
                  Navigator.of(context).pop(maxNumber.toInt());
                },
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
