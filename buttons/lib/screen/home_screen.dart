import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('버튼'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  //  함수를 넣어야함 + 절대적으로 무엇인가가를 return해야함
                  // foregroundColor - > 색깔이 들어가야함.
                  //MaterialState는 8가지의 enum 상태를 가짐. 앱 한정 아님. 모든 플랫폼 가능.
                  // hoverd - 호버링 상태(마우스 커서를 올려놓은 상태) -> 모바일에서 사용 불가.
                  // focused - 포커스 됐을 때 (텍스트필드)
                  // pressed - 눌렸을 때 (★★)
                  // dragged - 드래그 됐을 때
                  // selected - 선택됐을 때 (체크박스, 라디오버튼)
                  // scrollUnder - 다른 컴포넌트 밑으로 스크롤링 됐을 때
                  // disabled - 비활성화 됐을때 (버튼에서는 onPressed가 null이면) (★★)
                  // errored - 에러상태(텍스트필드 자주사용) , 버튼에선 쓸 일 없음
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.green;
                }
                return Colors.purple; // 그냥 return null을 하면 기본값이다.
              }), foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.white;
                }
                return Colors.red;
              }), padding: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return EdgeInsets.all(100.0);
                }
                return EdgeInsets.all(20.0);
              })),
              child: Text(
                'ButtonStyle',
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                // primary -- 메인컬러!
                primary: Colors.red,
                // onPrimary -- 글자 및 애니메이션 컬러
                onPrimary: Colors.black,
                // 그림자 색깔
                shadowColor: Colors.green,
                // 3D 입체감의 높이
                elevation: 10.0,
                textStyle: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
                padding: EdgeInsets.all(32.0),
                // 테두리 속성 지정
                side: BorderSide(
                  color: Colors.black,
                  width: 4.0,
                ),
              ),
              child: Text('Elevated Button'),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                // onPrimary만 없음 , 나머지는 Elevated Button과 동일
                // 주 요소가 글자랑 애니메이셔닝기에 primary가 글자랑 애니메이션 효과에 들어감.
                primary: Colors.green,
                backgroundColor: Colors.yellow,
              ),
              child: Text('Outlined Button'),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                primary: Colors.brown,
                backgroundColor: Colors.blue,
              ),
              child: Text('Text Button'),
            )
          ],
        ),
      ),
    );
  }
}
