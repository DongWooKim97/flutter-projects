import 'package:drift/drift.dart';

class Schedules extends Table {
  // PRIMARY KEY -> 자동으로 생성하는 방법을 알아보자
  // PK는 중복되면 안됨. -> 자동으로 숫자를 늘려라
  IntColumn get id => integer().autoIncrement()();

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

  // 생성날짜 -> 기계적으로 알 수 있는 숫자임. 항상 insert하는 순간 = DateTime.now();
  // clientDefault 함수와 DateTime.now를 통해 항상 insert하는 순간의 시간을 바로 된다.
  // 말 그대로 사용자의 기본값을 임의로 설정하는 함수이고, 나는 이것을 Datetime.now()로 설정해서 사용했다.
  // 또한 함수 그 자체로 Default라는 값이기에, 값을 안넣어줬을 때만 알아서 저렇게 되고, 내가 값을 임의로 넣었을 땐 넣은 값이 들어가게 된다.
  DateTimeColumn get createAt =>
      dateTime().clientDefault(() => DateTime.now())();
}
