import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_two_screen.dart';

class RouteOneScreen extends StatelessWidget {
  final int? number;

  const RouteOneScreen({
    this.number,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Route One',
      children: [
        Text(
          'arguments : ${number.toString()}',
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(456);
          },
          child: Text('Pop'),
        ),
        ElevatedButton(
          onPressed: () {
            // [HomeScreen() , RouteScreen(), RouteTwo() .. ] -> 스택구조(라우트스택) 왼쪽부터차고 오른쪽부터 나감
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => RouteTwoScreen(),
                settings: RouteSettings(
                    arguments: 789), // 메테리얼 라우트 페이지 스택에다가 추가하면서 넣을 수 이음.
              ),
            );
          },
          child: Text('Push'),
        ),
      ],
    );
  }
}

// pushNamed를 사용하면 settings를 일단 사용할 일이 없어짐. 그렇다면 arguments를 어떻게 전달하느냐?
// ~~.pushNamed('/', arguments : ~~~) 이런식으로 함수안에 파라미터로 바로 넘길 수 있음.
// MaterialPageRoute를 사용하지 않아도 그냥 쉽게 넘길 수 있는 방안
