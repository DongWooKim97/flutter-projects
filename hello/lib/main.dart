import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
        home:
            HomeScreen() // 이렇게 클래스이자 위젯명에 ()을 붙이면 오버라이딩 된 build()메서드가 실질적으로 실행된다고 생각하면 됨.
        ),
  );
}

// MaterialApp부터 하위 위젯들까지 전부 포함하려면 괄호도 많아지고 코드 가독성도 떨어지기에, 하나의 클래스로 만들어서 분리하자 .
// 그냥 class만 선언하면 위젯이 된게 아님. 뒤에 extends StatelessWidget이라고 선언하여 위젯을 선언해야함
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'asset/img/logo.png',
          ),
          CircularProgressIndicator(
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

// 핫리로드(Hot Reload)는 build()에 있는 것들만 재실행하기 때문에,
// 위와 같이 클래스(=위젯)을 분리하여 사용하면 저장(Ctrl + S)할 때 마다 손쉽게 핫리로드 되는 것을 볼 수 있음
