import 'package:calendar_schduler/component/custom_text_field.dart';
import 'package:calendar_schduler/constant/colors.dart';
import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatelessWidget {
  const ScheduleBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context)
        .viewInsets
        .bottom; // 위아래양옆에 해당하는 스크린에서 시스템UI 때문에 가려진 부분

    return GestureDetector(
      onTap: () {
        FocusScope.of(context)
            .requestFocus(FocusNode()); //암기, 현재 포커스가 되어있는 위젯에서 포커스를 없앨 수 있다.
      },
      child: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height / 2 + bottomInset,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: Padding(

              padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Time(),
                  SizedBox(height: 16.0),
                  _Content(),
                  SizedBox(height: 16.0),
                  _ColorPicker(),
                  SizedBox(height: 8.0),
                  _SaveButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ColorPicker extends StatelessWidget {
  const _ColorPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // 파라미터 - spacing
      spacing: 8.0, // 좌우 관격
      runSpacing: 10.0, // 위아래 간격
      children: [
        renderColor(Colors.red),
        renderColor(Colors.orange),
        renderColor(Colors.yellow),
        renderColor(Colors.green),
        renderColor(Colors.blue),
        renderColor(Colors.indigo),
        renderColor(Colors.purple),
      ],
    );
  }

  Widget renderColor(Color color) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      width: 32.0,
      height: 32.0,
    );
  }
}

class _Time extends StatelessWidget {
  const _Time({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 그냥 ROW에다 children들을 CustomTextField로 넣으면 얼마나 크기를 차지해야하는지 모르기때문에 오류발생 -> expanded필요
        Expanded(
          child: CustomTextField(
            label: '시작 시간',
            isTime: true,
          ),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: CustomTextField(
            label: '마감 시간',
            isTime: true,
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        isTime: false,
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            // 버튼을 꽉차게 만드는 방법 여러가지 -> Row로 감싼 후 Expanded!
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: PRIMARY_COLOR,
            ),
            child: Text('저장'),
          ),
        ),
      ],
    );
  }
}

// 바텀시트에는 레이블(각 항목의 제목들의 영역)들과 텍스트필드
// 만약 키보드 기능이 있으면 텍스트필드를 눌렀을때 키보드가 올라오는 만큼 아래에 패딩을 걸어줘야함.
