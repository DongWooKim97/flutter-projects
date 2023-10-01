import 'package:flutter/material.dart';
import 'package:scrollable_widgets/constant/colors.dart';

// 반드시 4개의 오버라이드 메서드를 생성해야함.
class _SliverFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  _SliverFixedHeaderDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
  });

  @override // 최대한 차지하게 하기
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  // TODO: implement maxExtent
  // extent = 높이 (최대)
  double get maxExtent => maxHeight;

  @override
  // TODO: implement minExtent
  // extent = 높이 (최소)
  double get minExtent => minHeight;

  @override
  // 파라미터 ? covariant - 상속된 클래스도 사용가능.
  // oldDelegate? 오래된 Delegate. 어떤 상황이냐. 빌드함수가 어떤 상황에서도 실행된다고 치자.
  // 빌드 되기 전에 존재하던 Delegate라고 생각하면됨.
  // 빌드된 후 - newDelegate, 전 oldDelegate
  // 새로 들어온 것 - this (새로운 Delegate)
  // shouldRebuild - 새로 build를 해야할지 말지 결정
  // 리턴값이 false면 빌드 절대 안함. true면 빌드 다시함.
  // 특정 컨디션에 맞춰 빌드할지 말지를 결정해야함.
  bool shouldRebuild(_SliverFixedHeaderDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }
}

class CustomScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  CustomScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // slivers안에는 무조건 Sliver관련 위젯만 들어가야한다. sliver키워드에 집착해야함.₩
          renderSliverAppBar(),
          renderHeader(),
          renderBuilderSliverList(),
          renderHeader(),
          renderBuilderSliverGrid(),
        ],
      ),
    );
  }

  SliverPersistentHeader renderHeader() {
    return SliverPersistentHeader(
      pinned: true, // 헤더에 pinned를 설정해놓으면 헤더가 점점 쌓임.
      delegate: _SliverFixedHeaderDelegate(
        // 파라미터 3개
        child: Container(
          color: Colors.black,
          child: const Center(
            child: Text(
              '신기하지',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        minHeight: 150,
        maxHeight: 200,
      ), // 직접 Class를 생성해야함
    );
  }

  SliverAppBar renderSliverAppBar() {
    return const SliverAppBar(
      // false일 땐 맨 위로 올라가야지만 보이는데trueaㅕㄴ 중간에 올려도 보임.
      floating: true,
      // true일 땐 기본 AppBar를 구현했을 떄 나오는 방식. 완전고정
      pinned: false,
      // 자석처럼 조금만 이동해도 아래로 쭉 내려옴. false일 떈 중간에도 걸침. 한번 해보자.
      // floting이 true일때만 사용할 수 있다.
      snap: false,
      // 맨 위에서 당겼을 떄 뒤에 Scaffold가 보임. 이걸 안보이게끔 하기위해
      // Appbar를 늘리는거임. defalut = false
      stretch: true,
      // 늘어났을때 최대사이즈
      expandedHeight: 200,
      // 닫혀있을때 최소사이즈
      collapsedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('FlexibleSpace'),
      ),
      title: Text('CustomScrollViewScreen'),
    );
  }

// GridView.builder와 좀 비슷함.
  SliverGrid renderBuilderSliverGrid() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      }, childCount: 100),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
      ),
    );
  }

// GridView.count와 유사함
  SliverGrid renderChildSliverGrid() {
    return SliverGrid(
      delegate: SliverChildListDelegate(numbers
          .map(
            (e) => renderContainer(
              color: rainbowColors[e % rainbowColors.length],
              index: e,
            ),
          )
          .toList()),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
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

// SliverChildlitDelegate가 UI를 결정하는게 아니고 , 우리가 안에 넣게 되는
// 파라미터가 실제로 이 리스트가 어떻게 보일지를 결정하는 것.!!

// delegate는 어떤 역할을 하냐? 어떤 함수가 들어와야 하는지, 어떤 파라미터가 이 안에 들어와야 하는지
// 정의만 하고있다. 용어 자체가 그런 의미. 함수의 포인터 수준?
