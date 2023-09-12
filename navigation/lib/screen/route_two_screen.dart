import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_three_screen.dart';

class RouteTwoScreen extends StatelessWidget {
  const RouteTwoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    //모달라우트에서 어떤 상황에서도 null값이 올 수 없다는 것을 확인하는것붵 다시 강의

    return MainLayout(
      title: 'Route Two',
      children: [
        Text(
          'arguments : ${arguments}',
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
            Navigator.of(context).pushNamed('/three', arguments: 999);
          },
          child: Text('Push Named'),
        ),
        ElevatedButton(
          onPressed: () {
            //[HomeScreen(), RouteOne(), RouteTwo(), RouteThree()] -> 기존의 라우트 스택
            //[HomeScreen(), RouteOne(), RouteThree()] -> replacement를 사용하면 사용한 스택을 삭제함
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => RouteThreeScreen(),
              ),
            );
          },
          child: Text(
            'Push Replacement',
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/three');
          },
          child: Text(
            'Push ReplacementNamed',
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => RouteThreeScreen()),
              (route) => route.settings.name == '/',
            );
          },
          child: Text('Push And Remove Until'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/three',
              (route) => route.settings.name == '/',
            );
          },
          child: Text('PushNamed And Remove Until'),
        )
      ],
    );
  }
}

// pushAndRemoveUntil를 실행하는 순간 두번째 파라미터에서 기존에 존재하는 모든 라우터에 각각 false-삭제, true-생존
// (route) => route.settings.name == '/',   route에 이름이 '/' 이 아닌 것들은 모조리 라우트 스택에서 삭제 -> 홈만 남아서 홈으로 돌아가기
