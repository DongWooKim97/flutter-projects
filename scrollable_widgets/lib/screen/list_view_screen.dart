import 'package:flutter/material.dart';
import 'package:scrollable_widgets/constant/colors.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

class ListViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  ListViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'ListViewScreen',
      body: renderSeparate(),
    );
  }

  // 3 => 2 + 중간 중간에 추가할 위젯을 넣을 수 있음
  Widget renderSeparate() {
    return ListView.separated(
      itemCount: 100,
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
      separatorBuilder: (context, index) {
        ++index; // 인덱스 맞추기 구색용
        return (index % 5 == 0)
            ? renderContainer(color: Colors.black, index: index, height: 100)
            : Container(); // 컨테이너를 선언하고 크기를 조절하지 않으면 그냥 아무것도 없음
      },
    );
  }

  // 2- > 보이는 것만 그림
  Widget renderBuilder() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
    );
  }

  // 1 .기본
  // 모든 위젯을 한번에 그려버림.
  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    print(index);
    return Container(
      height: height ?? 300,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}

//ListView.separated 는 결국 List사이에 구분선같은 역할을 하는 것들을 넣어줄 수 있는
// separateBuilder가 있다.  이 builder또한 기존의 builder를 작성하는 것처럼 작성할 수 있다.
// banner나 광고를 넣을 떄 엄청 유용하다.
