import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //빌드타임 떄 변수들의 값을 모두 알때 사용가능
            // const를 사용하면 붙이고난 첫 빌드 이후 다시 빌드하지 않아도 된다.
            // 앱이 실행되고 있을 때 단 한번만 그려놓으면 다시 그리지 않아도 되기에 test2 빌드 실행만 계속해서 나타나게 된다.
            const TestWidget(label: 'test1'),
            const TestWidget(label: 'test2'),
            ElevatedButton(
              // 이건 눌리는 순간(런타임때) 알 수 있기 때문에 빌드타임때 사용하는 const는 사용하지 못한다.
              onPressed: () {
                setState(() {});
              },
              child: const Text(
                '빌드!',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TestWidget extends StatelessWidget {
  final String label;

  const TestWidget({
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('$label 빌드실행');

    return Container(
      child: Text(
        label,
      ),
    );
  }
}
