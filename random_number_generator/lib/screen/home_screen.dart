import 'package:flutter/material.dart';
import 'package:random_number_generator/constant/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '랜덤숫자 생성기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.settings,
                      color: RED_COLOR,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [123, 456, 789]
                      .map(
                        (x) => Row(
                          children: x
                              .toString()
                              .split('')
                              .map(
                                (y) => Image.asset(
                                  'asset/img/$y.png',
                                  height: 70.0,
                                  width: 50.0,
                                ),
                              )
                              .toList(),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(
                // sizedBox는 Container에 약간의 하위호환
                width: double.infinity,
                child: Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          RED_COLOR, // primary = backgroundColor  ,, 일반적인 주된 색깔
                    ),
                    onPressed: () {},
                    child: Text('생성하기!'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
