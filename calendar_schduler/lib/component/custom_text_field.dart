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
    return TextField(
      cursorColor: Colors.grey,
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
