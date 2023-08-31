import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom : false,
        child: Container(
          color: Colors.black,
          // MediaQuery.of(Context)는 내가 사용하는 기종의 관련된 것을 가져올 수 있음
          // 앱 화면 크기 알아내는 것과 동일
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // CrossAxisAlignment - 반대축 정렬 , row일땐 세로, Column일땐 세로
            // Main(주축)에서는 차지할 수 있는 모든 공간을 차지함
            // 반대축같은 경우는 칼럼과 로우 모두 최소한의 공간만 차지함.
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                color: Colors.red,
                width: 50.0,
                height: 50.0,
              ),
              Container(
                color: Colors.orange,
                width: 50.0,
                height: 50.0,
              ),
              Container(
                color: Colors.yellow,
                width: 50.0,
                height: 50.0,
              ),
              Container(
                color: Colors.green,
                width: 50.0,
                height: 50.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
