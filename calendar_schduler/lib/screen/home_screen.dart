import 'package:calendar_schduler/component/calendar.dart';
import 'package:calendar_schduler/component/schedule_bottom_sheet.dart';
import 'package:calendar_schduler/component/schedule_card.dart';
import 'package:calendar_schduler/component/today_banner.dart';
import 'package:calendar_schduler/constant/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: renderFloatingActionButton(),
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
              selectedDay: selectedDay,
              focusedDay: focusedDay,
              onDaySelected: onDaySelected,
            ),
            SizedBox(height: 8.0),
            TodayBanner(
              selectedDay: selectedDay,
              scheduleCount: 3,
            ),
            SizedBox(height: 8.0),
            _ScheduleList(),
          ],
        ),
      ),
    );
  }

  FloatingActionButton renderFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet( // 기본의 최대사이즈가 화면의 반만사용 -> 전체로 늘려야함.
          context: context,
          isScrollControlled: true, // 전체로 늘리기 
          builder: (_) {
            return ScheduleBottomSheet();
          },
        );
      },
      backgroundColor: PRIMARY_COLOR,
      child: Icon(Icons.add),
    );
  }

  onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    // 어떤 날짜가 선택되었는지를 가지고 있어야하니까 stateful하게해야함
    // 슬라이더처럼 선택된 날짜가 얼마인지 다시 값을 넘겨서 build해줘야한다!!!!
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay;
    });
  }
}

class _ScheduleList extends StatelessWidget {
  const _ScheduleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.separated(
          itemCount: 10,
          separatorBuilder: (context, index) {
            // 각각의 아이템 사이에 들어갈 위젯들을 그려주는 역할.
            return SizedBox(height: 8.0);
          },
          itemBuilder: (context, index) {
            // 해당 인덱스에 도달했을 때 아이템빌더가 실행된다는 뜻
            // 인덱스를 이용하여 짝수는 뭐 어떻게, 홀수는 어떻게 다른 위젯으로 보여주기등 이런 식으로도 가능하다.
            return ScheduleCard(
              startTime: 12,
              endTime: 14,
              content: '${index + 1}. 프로그래밍 공부하기. ',
              color: Colors.red,
            );
          },
        ),
      ),
    );
  }
}
