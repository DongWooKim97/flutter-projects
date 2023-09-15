import 'package:calendar_schduler/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final defaultBoxDeco = BoxDecoration(
    borderRadius: BorderRadius.circular(60.0),
    color: Colors.grey[200],
  );
  final defaultTextStyle = TextStyle(
    color: Colors.grey[600],
    fontWeight: FontWeight.w700,
  );

  DateTime? selectedDay;
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: focusedDay,
      // 단순이 몇월을 보여줄지 결정하는 값
      firstDay: DateTime(1800),
      //가장 첫번째 날짜를 언제할건지 결정
      lastDay: DateTime(3000),
      //제일 미래의 날짜를 최대한 언제까지 결정
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
        ),
      ),
      calendarStyle: CalendarStyle(
        isTodayHighlighted: true,
        defaultDecoration: defaultBoxDeco,
        // 평일박스데코
        weekendDecoration: defaultBoxDeco,
        // 주말박스데코
        selectedDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(60.0),
          border: Border.all(
            width: 1.0,
            color: PRIMARY_COLOR,
          ),
        ),
        outsideDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
        ),
        defaultTextStyle: defaultTextStyle,
        weekendTextStyle: defaultTextStyle,
        selectedTextStyle: defaultTextStyle.copyWith(
          color: PRIMARY_COLOR,
        ),
      ),
      onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
        // 어떤 날짜가 선택되었는지를 가지고 있어야하니까 stateful하게해야함
        // 슬라이더처럼 선택된 날짜가 얼마인지 다시 값을 넘겨서 build해줘야한다!!!!
        setState(() {
          this.selectedDay = selectedDay;
          this.focusedDay = selectedDay;
        });
      },
      selectedDayPredicate: (DateTime date) {
        //date == selectedDay를 안하는 이유는 이렇게 하면 시/분/초 까지 다 비교하기때문에. 우리는 그럴 필요는 없었기에 사용하지 않음.
        if (selectedDay == null) {
          return false;
        }

        return date.year == selectedDay!.year &&
            date.month == selectedDay!.month &&
            date.day == selectedDay!.day;
      },
    );
  }
}

// intl 패키지를 이용한 다국어 사용 강의 시작
// 우선 에러발생. 캘린더의 기본값은 동그라미로 설정되어있느넫, 에러난 곳을 찾아가보니까  Can't have a border radius if you're a circle.
// 너가 동그라미면 border radius를 가질 수 없다. 지금 내가 보기에 현재 날짜나 클릭한 날짜들은 동그라미 처럼 보이는데?라고 생각할 수 있지만
// 우리는 네모를 많이 깎아서 동그라미'처럼'보이는 것 뿐 동그라미가 아님. 그래서 저것들을 동그라미로 돌려줘야 해결되지 않을까 생각
// outsideDecoration: BoxDecoration(
//           shape: BoxShape.rectangle,
// ), -!> 이 코드로 해결함.

// -?> 2번째 에러. 전월 31일을 누르면 그쪽으로 포커싱해야함. 근데 그게 안됨. 그걸 어떻게 수정? focusedDay를 수정하면 될듯.

