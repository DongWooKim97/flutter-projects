import 'package:flutter/material.dart';
import 'package:scrollable_widgets/constant/colors.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

class ReorderableListViewScreen extends StatefulWidget {
  const ReorderableListViewScreen({super.key});

  @override
  State<ReorderableListViewScreen> createState() =>
      _ReorderableListViewScreenState();
}

class _ReorderableListViewScreenState extends State<ReorderableListViewScreen> {
  List<int> numbers = List.generate(100, (index) => index);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'ReorderableListViewScreen',
      body: ReorderableListView( // 각각 유니크한 값을 지정해줘야함.
        children: numbers
            .map((e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length], index: e))
            .toList(),
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }

            final item = numbers.removeAt(oldIndex);
            numbers.insert(newIndex, item);
          });
        },
      ),
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

// Reorderable 자체가 순서를 바꿀 수 있는 리스트이다!!.
// 리스트안에 있는 값을 길게 눌러가지고 값의 순서를 변경할 수 있다.
// 변경이 된 후에는 바라보고 있는 데이터 안에서도 순서를 바꿔줘야한다.
// 이는 화면에서 순서를 바꿔주는 역할을 하고, 실제 데이터를 바꿔주진 않음.
// 실제 데이터 순서를 바꿔주는 것은 우리가 직접 순수하게 해야함.
// 이걸 onReorder에서 하는것

// onReorder가 oldIndex와 newIndex를 어떻게 산정하는지를 알아야한다.
// 순서 바꾸기 전 인덱스, 후 인덱스
// [red, orange. yellow]
// [0, 1, 2]
// red를 yello다음으로 옮기고 싶다. -> 새로 이동할 인덱스를 산정해야함!!
// red : 0 -> 3번 인덱스로 이동. 즉, 이건 삭제하기전 총 인덱스값으로함
// [orange, yellow, red] ?? 여기서는 2번 인덱스인데????
// old , new 모두 값을 옮기기 전에 위치를 산정한다. 이게 rule!!!
// 옮기고 난 후에 인덱스는 우리가 해결하는 문제지, 컴퓨터가 하는 문제가 아님.
// 그렇기에 무조건 옮기기전의 위치로 인덱스값을 산정해야한다.

// [red, orange, yellow]
// yellow를 맨 앞으로 옮기고 싶다. .
// yellow : 2 oldIndex -> 0 newIndex
// [yellow, red, orange]
// 2번 인덱스에서 0번인덱스로 옮김.
// 이 상황에서는 옮기고 나서도 0번 인덱스가 맞음!
