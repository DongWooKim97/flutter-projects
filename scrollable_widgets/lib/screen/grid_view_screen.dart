import 'package:flutter/material.dart';
import 'package:scrollable_widgets/constant/colors.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

class GridViewScreen extends StatelessWidget {
  List<int> numbers = List.generate(100, (index) => index);

  GridViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'GridViewScreen',
      body: renderMaxExtent(),
    );
  }
  // 3 -> 최대 사이즈
  Widget renderMaxExtent() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        // 최대사이즈를 정하면 알아서 들어감
        // 정렬할 수 있는 최댓값으로만 사용해서 최대사이즈만 정해주면 알아서 정해줌
          maxCrossAxisExtent: 200 //이 파라미터 필수!! => 길이
      ),
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
    );
  }

  // 2 ->보이는것만 그림
  Widget renderBuilderCrossAxisCount() {
    return GridView.builder(
      // SliverGridDelegate 기본은 안씀.
      // Sliver는 무조건 기억해야함.
      // gridDelegate란 그리드를 어떻게 그릴건지 정의하는 곳!
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12.0,
        crossAxisSpacing: 12.0,
      ),
      itemBuilder: (context, index) {
        //왼쪽부터 오른쪽부터 숫자가 늘어남
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
    );
  }

  Widget renderCount() {
    // 기본 생성자 사용 X
    return GridView.count(
      //  이것또한 100개를 한번에 그렸다 . = 한번에 다 그림 !
      crossAxisCount: 2,
      mainAxisSpacing: 12.0, // 세로간격
      crossAxisSpacing: 12.0, // 가로 간격
      children: numbers
          .map((e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length],
                index: e,
              ))
          .toList(),
    );
  }

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

// 모든 Grid는 위(up)에서 아래(down)이 MainAxis이다. == Column
// crossAxisCount: -> 크로스니까 가로로 몇개 만들거냐!!
