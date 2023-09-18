import 'package:calendar_schduler/database/drift_database.dart';
import 'package:calendar_schduler/screen/home_screen.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:calendar_schduler/database/drift_database.dart';

const DEFAULT_COLORS = [
  'F44336', // 빨강
  'FF9800', // 주황
  'FFEB3B', // 노랑
  'FCAF50', // 초록
  '2196F3', // 파랑
  '3F51B5', // 남색
  '9C27B0', // 보라
];


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 플러터 초기화 됐는지 확인.(준비됐는지 가디라지)

  await initializeDateFormatting(); // intl패키지 사용가능

  final database = LocalDatabase(); // 데이터베이스 생성
  final colors = await database.getCategoryColors(); // 데이터베이스에 있는 색깔들을 가져옴.
  if(colors.isEmpty) { // 컬러가 없다?
    for(String hexCode in DEFAULT_COLORS) {
      await database.createCategoryColor(
        CategoryColorsCompanion( // 하나씩 넣는다!!
          hexCode: Value(hexCode), // 데이터베이스에 값을 넣을때 무조건 Value()로 바인디 해서 넣어야한다.
        ),
      );
    }
  }

  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      home: HomeScreen(),
    ),
  );
}
