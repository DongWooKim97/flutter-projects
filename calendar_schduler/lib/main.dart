import 'package:calendar_schduler/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 플러터 초기화 됐는지 확인.(준비됐는지 가디라지)

  await initializeDateFormatting(); // intl패키지 사용가능

  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      home: HomeScreen(),
    ),
  );
}
