import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';

class RouteThreeScreen extends StatelessWidget {
  const RouteThreeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments;

    return MainLayout(
      title: 'Route Three',
      children: [
        Text(
          'argument : ${argument}',
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Pop'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/');
          },
          child: Text(
            'Push Named',
          ),
        ),
      ],
    );
  }
}

// pushNamed는 우리가 main.dart파일에서 설정한 라우트 이름들을 넣어서 라우팅할 수 있게 하는 함수.
