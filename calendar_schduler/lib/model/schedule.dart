import 'package:drift/drift.dart';

class Schedules extends Table {
  // PRIMARY KEY -> 자동으로 생성하는 방법을 알아보자
  IntColumn get id => integer()();

  // 내용
  TextColumn get content => text()();

  // 일정 날짜
  DateTimeColumn get date => dateTime()();

  // 시작 시간
  IntColumn get startTime => integer()();

  // 끝 시간
  IntColumn get endTime => integer()();

  // Category Color Table ID -> JOIN
  IntColumn get colorId => integer()();

  // 생성날짜
  DateTimeColumn get createAt => dateTime()(); 

}
