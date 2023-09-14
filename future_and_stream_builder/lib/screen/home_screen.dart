import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 16.0,
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          // 퓨처빌더는 기존의 데이터값을 기억함. 이것이 "캐싱". 그래서 done되기 전까지는 snapshot.data의 값이 바뀌지 않음.
          future: getNumber(),
          builder: (context, snapshot) {
            //기본적으로 많이하는 방식
            if (snapshot.hasData) {
              //데이터가 있을 때 위젯 렌더링
            }

            if (snapshot.hasError) {
              // 에러가 났을 때 위젯 렌더링
            }
            // 둘 다 아닐 때 = 로딩중일때 위젯 렌더링
            // 스냅샷 값이 바뀔 때도 재실행 +setState가 실행되도 재실행
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Future Builder',
                  style: textStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  'Constate : ${snapshot.connectionState}',
                  style: textStyle,
                ),
                Text(
                  'Data : ${snapshot.data}',
                  style: textStyle,
                ),
                Text(
                  'Error : ${snapshot.error}',
                  style: textStyle,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Text('setState'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<int> getNumber() async {
    await Future.delayed(Duration(seconds: 3));
    final random = Random();
    // 에러를 던지기 위해서는 throw라는 키워드를 사용해야한다.
    // throw Exception('에러가 발생했습니다.');

    return random.nextInt(100);
  }
}

// Future build에는 당연하게도 future함수가 들어가야한다 .
// 또한 화면에 Connection.state.waiting 에서 done으로 바뀌게 되는데 이는 state가 바뀔 때 마다 builder함수가 계속해서 새롭게 불리다는 의미이다.
// 빌더함수를 다시 실행하는 순간은 setState가 실행되어 builder함수가 다시 한번 실행되는 경우가 있다.

// 중요한건 로딩중일 때 캐싱을 통해 로딩중이 아니라고 유저로 하여금 착각을 불러올 수 있어 앱이 느리다고 판단할 수 없게끔 눈속임이 중요하다
