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
