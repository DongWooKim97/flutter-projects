import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        bottom: false,
        child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                _TopPart(),
                _BottomPart(),
              ],
            )),
      ),
    );
  }
}

class _TopPart extends StatefulWidget {
  const _TopPart({super.key});

  @override
  State<_TopPart> createState() => _TopPartState();
}

class _TopPartState extends State<_TopPart> {
  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'U&I',
            style: TextStyle(
                color: Colors.white, fontFamily: 'parisienne', fontSize: 80.0),
          ),
          Column(
            children: [
              Text(
                '우리 처음 만난날',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'sunflower',
                  fontSize: 30.0,
                ),
              ),
              Text(
                '${selectedDate.year}.${selectedDate.month}.${selectedDate.day}',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'sunflower',
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
          IconButton(
            iconSize: 60.0,
            onPressed: () {
              // dialog -> date picker (기능 다 만들어져있음)
              showCupertinoDialog(
                context: context,
                barrierDismissible: true, // 위젯의 사이즈 넘어간 것을 누르면 꺼짐
                builder: (BuildContext context) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      // 플러터의 특징 : 특정 위젯이 어디에 정렬해야하는지 알 수없으면 최대한 사이즈로 먹어버린다. 그래서 현재는 전체화면을 다 먹어버림
                      // align이라는 위젯을 사용해서 어디에 정렬할건지(여기서는 showDialog를) 알려줘야만 한다
                      color: Colors.white,
                      height: 300.0,
                      child: CupertinoDatePicker(
                        // 데이트픽커는 디폴트로 실행하면 now로 실행되는데, 우리는 maximunDate를 now로 했기에에러
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: selectedDate,
                        maximumDate: DateTime(
                          now.year,
                          now.month,
                          now.day,
                        ),
                        onDateTimeChanged: (DateTime date) {
                          setState(() {
                            selectedDate = date;
                          });
                        }, // 필수로 넣어야함
                      ),
                    ),
                  );
                },
              );
            },
            icon: Icon(
              Icons.favorite,
              color: Colors.red[700],
            ),
          ),
          Text(
            'D+${DateTime(
                  now.year,
                  now.month,
                  now.day,
                ).difference(selectedDate).inDays + 1}',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'sunflower',
              fontWeight: FontWeight.w700,
              fontSize: 50.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Image.asset('asset/img/middle_image.png'),
    );
  }
}
