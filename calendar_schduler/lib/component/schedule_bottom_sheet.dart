import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatelessWidget {
  const ScheduleBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context)
        .viewInsets
        .bottom; // 위아래양옆에 해당하는 스크린에서 시스템UI 때문에 가려진 부분

    return Container(
      height: MediaQuery.of(context).size.height / 2 + bottomInset,
      color: Colors.white,
      child: Padding(
        padding:  EdgeInsets.only(bottom: bottomInset),
        child: Column(
          children: [
            TextField(),
          ],
        ),
      ),
    );
  }
}

// 바텀시트에는 레이블(각 항목의 제목들의 영역)들과 텍스트필드
// 만약 키보드 기능이 있으면 텍스트필드를 눌렀을때 키보드가 올라오는 만큼 아래에 패딩을 걸어줘야함.
