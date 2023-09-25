import 'package:flutter/material.dart';
import 'package:scrollable_widgets/constant/colors.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

class SingleChildScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(
    100, // 만큼의 length를 만든다!
    (index) => index, // 인덱스는 순서. 100개의 순서. -> 어차피 우린 0부터 세야하니ㅏㄲ index를 그대로 받음
  );

  SingleChildScrollViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'SingChildScrollView',
      body: renderPerformance(),
    );
  }

  // 1 -> 기본 렌더링법
  Widget renderSimple() {
    return SingleChildScrollView(
      child: Column(
        children: rainbowColors.map((e) => renderContainer(color: e)).toList(),
      ),
    );
  }

  // 2-> 화면을 넘어가지 않아도 스크롤 되도록하기
  Widget renderAlwaysScroll() {
    return SingleChildScrollView(
      // 스크롤이 어떻게 작동하는지 정할 수 있는 물리? 피지컬? 그런것들
      // NeverScrollableScrollPhysics ->화면이 넘어가지 않는 이상 스크롤이 되지 않도록 -> default
      // AlwaysScrollableScrollPhysics -> 강제로 스크롤되도록 설정하는것.
      // Bouncing -> IOS에서 튕기는 형식의 스크롤이 생김. 즉 남는 공간을 보여주도록 설정.
      physics: AlwaysScrollableScrollPhysics(), // 정해놓은 크기 밑으로 내리면 잘림
      child: Column(
        children: [
          renderContainer(color: Colors.black),
        ],
      ),
    );
  }

  // 3 -> 위젯이 잘리지 않게 하기 ->clip
  Widget renderClip() {
    return SingleChildScrollView(
      clipBehavior: Clip.none, // 잘렸을 때 어떤 방식으로 자를거냐
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          renderContainer(color: Colors.black),
        ],
      ),
    );
  }

  // 4 -> 여러가지 physics정리
  Widget renderPhysics() {
    return SingleChildScrollView(
      // 스크롤뷰가 당겨지면서 생기는 남는 부분이 흰색으로 채워짐.
      // -> Scaffold의 배경색임. 물론 IOS에서만 그럼.안드로이드의 기본설정은 안당겨지는 Clamping
      // Bouncing -> IOS에서 튕기는 형식의 스크롤이 생김. 즉 남는 공간을 보여주도록 설정.
      // Clamping -> 안드로이드 스타일.
      physics: BouncingScrollPhysics(),
      child: Column(
        children: rainbowColors.map((e) => renderContainer(color: e)).toList(),
      ),
    );
  }

  // 5 -> SingleChildScrollView Performance
  Widget renderPerformance() {
    return SingleChildScrollView(
      child: Column(
        children: numbers
            .map(
              (e) => renderContainer(
                  // print로 로그를 찍어본 결과 100번의 renderContainer함수가 한번에 다 실행됐다는 뜻임.
                  color: rainbowColors[e % rainbowColors.length],
                  index: e),
            )
            .toList(),
      ),
    );
  }

  Widget renderContainer({
    required Color color,
    int? index,
  }) {
    if (index != null) print(index);
    return Container(
      height: 300,
      color: color,
    );
  }
}

// ListView.builder는 보이지 않는 곳은 렌더링하지 않고, 자기가 렌더링 될 떄쯤에 렌더링되어서
// 퍼포먼스를 최적화 시킨다.
// 하지만 print로 로그를 찍어본 결과, SingleChildScrollView는 안에 있는 위젯을 한번에 다 렌더링해버림.
// 퍼포먼스 저하의 여지가 있음.
// 즉, 퍼포먼스 저하의 여지가 있으니 SingleChildScrollView는 조심해서 사용할 것을 권장함.
