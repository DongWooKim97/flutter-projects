import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_one_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // async 무조건 써야 가능
        // return true; - pop 가능
        // return false; - pop 불가능
        final canPop = Navigator.of(context).canPop();

        return canPop;
      },
      child: MainLayout(
        title: 'Home Screen',
        children: [
          ElevatedButton(
            onPressed: () {
              print(Navigator.of(context).canPop());
            },
            child: Text('Can Pop!'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Pop!'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).maybePop();
            },
            child: Text('Maybe Pop!'),
          ),
          ElevatedButton(
            onPressed: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      RouteOneScreen(
                        number: 123,
                      ),
                ),
              );
            },
            child: Text('Push'),
          )
        ],
      ),
    );
  }
}

// MaybePop -> 더 이상 뒤로갈 페이지나 라우트가 없을 때 뒤로가는 것을 방지해줌 + 뒤로 갈 수 있다면 pop과 동일하게 result를 가지고 전달할 수 도 있음.
// CanPop -> 아무것도 실행되지 않음. 그러나 print()로 찍어보면 true/false값으로 나오는데, 그냥 상태 확인용도로 사용함 -> 뒤에 아무 라우트도 없다는 것을 알리는 용도래
