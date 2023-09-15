import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: DateTime.now(), // 단순이 몇월을 보여줄지 결정하는 값
      firstDay: DateTime(1800), //가장 첫번째 날짜를 언제할건지 결정
      lastDay: DateTime(3000), //제일 미래의 날짜를 최대한 언제까지 결정
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
        ),
      ),
      onDaySelected: (DateTime selectedDay, DateTime focusedDay) {

      },
    );
  }
}
