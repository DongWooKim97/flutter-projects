import 'package:calendar_schduler/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isTime;

  const CustomTextField({
    required this.label,
    required this.isTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (isTime) renderTextField(),
        if (!isTime) Expanded(child: renderTextField()),
      ],
    );
  }

  Widget renderTextField() {
    return TextFormField(
      // Form -> input들을 동시에 관리 -> 특정 버튼같은걸 눌렀을 때 한번에 여러 필드에 어떤 오류가 있는지 알 수 있음.
      validator: (String? val) {
        // null이 return되면 에러가 없다.
        // error가 있으면 error를 String값으로 리턴해준다.
        if(val == null || val.isEmpty) {
          return '값을 입력해주세요.';
        }

        if(isTime) {
          int time = int.parse(val!);

          if(time < 0) {
            return '0 이상의 숫자를 입력해주세요';
          }
          if(time > 24) {
            return '24 이하의 숫자를 입력해주세요.';
          }
        } else {
          if(val.length > 500) {
            return '500자 이하의 글자를 입력해주세요.';
          }
        }
        return null;
        // return null; // 기본은 return null이다.
      },
      cursorColor: Colors.grey,
      maxLength: 500,
      expands: !isTime,
      maxLines: isTime ? 1 : null,
      // maxLine-> 줄 최대개수 , " default = 1, null= 무한 , 시간은 1줄 내용은 무한"
      keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
      inputFormatters: isTime
          ? [
              // 혹여나 숫자만 입력하는 칸에 글자를 입력하게 되는 버그를 방지하기 위함.
              // 숫자외의 모든글자 삭제되고, 입력이 안됨.
              FilteringTextInputFormatter.digitsOnly
            ]
          : [],
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.grey[300],
      ),
    );
  }
}
