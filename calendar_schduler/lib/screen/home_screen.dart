import 'package:calendar_schduler/component/calendar.dart';
import 'package:calendar_schduler/component/schedule_card.dart';
import 'package:calendar_schduler/component/today_banner.dart';
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ScheduleCard(
                startTime: 12,
                endTime: 14,
                content: '프로그래밍 공부하기.',
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
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
