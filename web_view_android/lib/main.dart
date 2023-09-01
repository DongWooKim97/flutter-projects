import 'package:flutter/material.dart';
import 'package:web_view_android/screen/home_screen.dart';

void main() {
  // Flutter 프레임워크가 앱을 실행할 준비가 될 때 까지 기다린다.
  // main함수에 runApp 함수가 하나밖에 없으면 자동으로 실행되는 것이기에 굳이 사용안해도 된다.
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

