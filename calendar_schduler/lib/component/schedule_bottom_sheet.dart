import 'package:calendar_schduler/component/custom_text_field.dart';
import 'package:calendar_schduler/constant/colors.dart';
import 'package:calendar_schduler/database/drift_database.dart';
import 'package:calendar_schduler/model/category_color.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:calendar_schduler/database/drift_database.dart';

// Form의 Key라는 State를 관리해야 하니까 Stateful로 변경
class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({Key? key}) : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  int? startTime;
  int? endTime;
  String? content;

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
              child: Form(
                //Form은 key라는 값을 넣어야함.
                autovalidateMode: AutovalidateMode.always,
                // live로 validation하는 방법
                key: formKey,
                // key에는 글로벌키를 넣어서 하나의 컨트롤러 역할 권한을 부여
                child: Column(
                  //텍스트필드가 있는 하위보다 상위(아무데나)에 Form위젯을 설정하면 한번에 모든 텍스트필드들을 관리할 수 있다.
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Time(
                      onStartSaved: (String? val) {
                        startTime = int.parse(val!);
                      },
                      onEndSaved: (String? val) {
                        endTime = int.parse(val!);
                      },
                    ),
                    SizedBox(height: 16.0),
                    _Content(
                      onSaved: (String? val) {
                        content = val;
                      },
                    ),
                    SizedBox(height: 16.0),
                    FutureBuilder<List<CategoryColor>>(
                      // GetIt을 통해 dependencies Injection을 하는 방법을 배웠다. 근데 이게 DI인지 모르겠음 ㅋㅎ.
                      future: GetIt.I<LocalDatabase>().getCategoryColors(), // 마치 데이터베이스를 가져온것 처럼 다른 함수들을 모조리 사용할 수 있다 .
                      builder: (context, snapshot) {
                        print(snapshot.data);
                        return _ColorPicker(
                          colors: [],
                        );
                      },
                    ),
                    SizedBox(height: 8.0),
                    _SaveButton(
                      onPressed: onSavePressed,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSavePressed() {
    // formKey는 생성을 했는데, formWidget과 결합을 안했을 때 아래상황
    if (formKey.currentState == null) {
      return;
    }
    // validate를 실행하는 순간 formKey가 입력되어있는 form아래에 있는 모든 TextFormField들의 Validator가 실행된다.
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    } else {
      print('에러가 있습니다.');
    }
  }
}

class _ColorPicker extends StatelessWidget {
  final List<Color> colors;

  const _ColorPicker({
    required this.colors,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // 파라미터 - spacing
      spacing: 8.0, // 좌우 관격
      runSpacing: 10.0, // 위아래 간격
      children: colors.map((e) => renderColor(e)).toList(),
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
  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;

  const _Time({
    required this.onStartSaved,
    required this.onEndSaved,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 그냥 ROW에다 children들을 CustomTextField로 넣으면 얼마나 크기를 차지해야하는지 모르기때문에 오류발생 -> expanded필요
        Expanded(
          child: CustomTextField(
            label: '시작 시간',
            isTime: true,
            onSaved: onStartSaved,
          ),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: CustomTextField(
            label: '마감 시간',
            isTime: true,
            onSaved: onEndSaved,
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onSaved;

  const _Content({
    required this.onSaved,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        isTime: false,
        onSaved: onSaved,
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SaveButton({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            // 버튼을 꽉차게 만드는 방법 여러가지 -> Row로 감싼 후 Expanded!
            onPressed: onPressed,
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
