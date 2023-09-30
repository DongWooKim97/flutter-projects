import 'package:flutter/material.dart';
import 'package:scrollable_widgets/constant/colors.dart';

class CustomScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  CustomScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(title: Text('CustomScrollViewScreen')),
          renderBuilderSliverList(),
        ],
      ),
    );
  }

  SliverList renderBuilderSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return renderContainer(
            color: rainbowColors[index % rainbowColors.length],
            index: index,
          );
        },
        childCount: 100, // 원하는 child 개수 설정
      ),
    );
  }

  SliverList renderChildSliverList() {
    // 기본생성자 SliverList
    return SliverList(
      delegate: SliverChildListDelegate(
        numbers
            .map(
              (e) => renderContainer(
                  color: rainbowColors[e % rainbowColors.length], index: e),
            )
            .toList(),
      ),
    );
  }

  // sliver란 모든 형태의 리스트들을 다 쓸 수 있는 위젯이다.

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

// 칼럼 안에다 리스트뷰를 하나 만들고
// 추가적으로 그 밑에 그리드뷰를 하나 넣고싶다

// 모든 리스트 또는 스크롤 가능한 위젯들은
// 칼럼 안에다 넣었을 떄 Expanded를 사용하지 않으면 에러가 난다. !! 무조건!!

// 왜냐하면 리스트뷰는 무한하게 넣을 수 있다. 그래서 이론상 무한한 높이를 가질 수 있다.
// 따라서 칼럼이 최대 크기를 정해줘야함. 그게 Expanded고 그 중 하나의 일종이다.

// Delegate
// 어떤 형태로 SliverList를 만들어낼지 정할수있음.
// ListView에도 ListView의 기본 생성자로 childrend에 때려박을 수도 있고,
// ListView.Builder를 사용해서 만들어낼 수 있듯이 이러한 형태를 정하는게 delegate
