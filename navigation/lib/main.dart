import 'package:flutter/material.dart';
import 'package:navigation/constatnt/routes/routes_address.dart';
import 'package:navigation/screen/home_screen.dart';
import 'package:navigation/screen/route_one_screen.dart';
import 'package:navigation/screen/route_three_screen.dart';
import 'package:navigation/screen/route_two_screen.dart';

void main() {
  runApp(
    MaterialApp(
      // home: HomeScreen(),
      initialRoute: '/',
      routes: {
        HOME_ROUTE: (context) => HomeScreen(),
        ONE_ROUTE: (context) => RouteOneScreen(),
        TWO_ROUTE: (context) => RouteTwoScreen(),
        THREE_ROUTE: (context) => RouteThreeScreen(),
      },
    ),
  );
}

// routes를 사용하려면 key:value로 라우트들을 지정해줘야한다.
// 위와 같은 방식으로. 또한 routes를 사용하면 플러터는 어떤 화면이 앱을 실행했을 때 가장 먼저 나타나는지 모르기때문에
// initialRoute 라는 파라미터를 통해 랜딩라우트페이지를 지정해줘야한다.

// Navigator는 기본적으로 일반함수 랑 일반함수+named로 구성되어있다.
