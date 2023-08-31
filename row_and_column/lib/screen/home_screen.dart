import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom : false,
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              // Expanded / Flexible -> 무조건 기억! row와 column children에만 사용 가능
              // Expanded : 남아있는 모든 공간을 차지하라는 뜻 , 2개 이상 사용시  1/N으로 남아있는 공간을 동일하게 나눠가짐
              // Expaned 中 flex -> 남아있는 공간을 나눠가지는 비율이다. 디폴트는 1로 되어있어 따로 설정을 하지 않으면 동일하게 나눠가지지만,
              // flex를 따로 설정해주면 그 파라미터값만큼 비율을 가져갈 수 있다.
              // Flexible 
              Flexible(
                child: Container(
                  color: Colors.red,
                  width: 50.0,
                  height: 50.0,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.orange,
                  width: 50.0,
                  height: 50.0,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.yellow,
                  width: 50.0,
                  height: 50.0,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.green,
                  width: 50.0,
                  height: 50.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
