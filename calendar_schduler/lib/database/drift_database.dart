// import -> private 값들은 불러올 수 없다.
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

import '../model/category_color.dart';
import '../model/schedule.dart';
import 'package:path/path.dart' as p;

// import보다 넓은 기능을 하는 part. private 값들을 불러올 수 있음. 파일지정.
// g를 붙이면 generate -> 코드가 실행되면 url과 같은 파일명이 자동으로 생성되는것.
part 'drift_database.g.dart';

//데코레이터
// 인스턴스 생성하듯이 ()하면 안되고 타입만 넣어야함.
// tables:  => 테이블들로 사용할 것이다.
@DriftDatabase(
  tables: [
    Schedules,
    CategoryColors,
  ],
)
// 지금 extends한 _$LocalDatabase파일은 ~~~.g.dart가 생성되면서 , 그 안에 존재할 것.
// 또한 private값인데 불러올 수 있는 이유는 part이기에!
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  // insert하는 방법
  Future<int> createSchedule(SchedulesCompanion data) =>
      into(schedules).insert(data);

  Future<int> createCategoryColor(CategoryColorsCompanion data) =>
      into(categoryColors).insert(data);

  // select하는 방법
  Future<List<CategoryColor>> getCategoryColors() =>
      select(categoryColors).get();

  @override
// 디비에 설정한 테이블들의 상태(상태버전)
// 우리가 디비를 변경할 때 (구조자체가, 테이블 구조가 변경될 때) -> 스키마 버전을 높여줘야한다.
  int get schemaVersion => 1;
}

// 데이터베이스를 어디에 저장할건지 지정.
LazyDatabase _openConnection() {
  return LazyDatabase(
    () async {
      final dbFolder =
          await getApplicationDocumentsDirectory(); // 플러터에서 지정해준, 프로바이더가 지정해준 디렉토리를 사용할 수 있는 위치
      final file = File(p.join(
          dbFolder.path, 'db.sqlite')); // 그 위치에 db.sqlite라는 파일명으로 새로운 파일을 만듬.
      return NativeDatabase(file);
    },
  );
}
