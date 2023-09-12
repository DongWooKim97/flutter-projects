import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_number_generator/constant/color.dart';
import 'package:random_number_generator/screen/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int maxNumber = 1000;

  List<int> randomNumbers = [
    123,
    456,
    789,
  ];

  onRandomNumberGenerate() {
    final rand = Random();
    final Set<int> newNumbers = {};

    while (newNumbers.length != 3) {
      final number = rand.nextInt(maxNumber);

      newNumbers.add(number);

      setState(() {
        randomNumbers = newNumbers.toList();
      });
    }
  }

  void onSettingsPop() async {
    // list -- add 와 같은 함수 = push // 라우터스택!!
    // 푸시했던 라우터페이지를 통해 다시 데이터를 돌려받으면 된다.
    // 다만 , 그냥 받을 순 없고 async로 받아야한다.
    // 어떤값이 리턴될지 정할 수 있다.제너릭을 통핸
    final result = await Navigator.of(context).push<int>(
      MaterialPageRoute(builder: (BuildContext context) {
        return SettingsScreen();
      }),
    ); // 네비게이터 활성화

    if (result != null) {
      setState(() {
        maxNumber = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(
                onPressed: onSettingsPop,
              ),
              _Body(randomNumbers: randomNumbers),
              _Footer(onPressed: onRandomNumberGenerate),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onPressed;

  const _Header({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '랜덤숫자 생성기',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        IconButton(
          // onPressed를 위로 올려 상태관리를 일괄적으로 해줘야한다.
          onPressed: onPressed,
          icon: Icon(
            Icons.settings,
            color: RED_COLOR,
          ),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final List<int> randomNumbers;

  const _Body({
    required this.randomNumbers,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: randomNumbers
            .asMap()
            .entries
            .map(
              (x) => Padding(
                // asMap()을 사용하면 우리는 key값을 활용할 수 있다.
                padding: EdgeInsets.only(bottom: x.key == 2 ? 0 : 16.0),
                child: Row(
                  children: x.value
                      .toString()
                      .split('')
                      .map(
                        (y) => Image.asset(
                          'asset/img/$y.png',
                          height: 70.0,
                          width: 50.0,
                        ),
                      )
                      .toList(),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPressed;

  const _Footer({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // sizedBox는 Container에 약간의 하위호환
      width: double.infinity,
      child: Expanded(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                RED_COLOR, // primary = backgroundColor  ,, 일반적인 주된 색깔
          ),
          onPressed: onPressed,
          child: Text('생성하기!'),
        ),
      ),
    );
  }
}
