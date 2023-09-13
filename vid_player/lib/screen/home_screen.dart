import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../component/custom_video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: video == null ? renderEmpty() : renderVideo(),
    );
  }

  Widget renderVideo() {
    return Center(
      child: CustomVideoPlayer(
        video: video!,
        onNewVideoPressed: onNewVideoPressed,
      ),
    );
  }

  Widget renderEmpty() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: getBoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(
            onTap: onNewVideoPressed,
          ),
          SizedBox(height: 30.0),
          _AppName(),
        ],
      ),
    );
  }

  void onNewVideoPressed() async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (video != null) {
      setState(() {
        this.video = video;
      });
    }
  }

  BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF2A3A7C),
          Color(0xFF000118),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  final VoidCallback onTap;

  const _Logo({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        'asset/image/logo.png',
      ),
    );
  }
}

class _AppName extends StatelessWidget {
  const _AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 변수사용시 중복 제거 가능
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.w300,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Video',
          style: textStyle,
        ),
        Text(
          'PLAYER',
          style: textStyle.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

// decoration과 color를 함께 쓸 수 없다. -> color가 BoxDecoration 안으로 들어가야한다.
// decoration안에 파라미터 넣는방법이 HomeScreen 구현에서 중요

// 기존 스타일에 추가값을 덮어씌우기 위해서는 ~~~.copyWith()을 통해 사용하고, 덮어쓰고자 하는 값의 파라미터 이름만 넣고 변경한다.
// SizedBox를 Padding 대신에 사용하는 이유는? Padding은 한번 감싸야한다.-> 탭이 하나 더 들어가기때문에 보기싫어서 SizedBox를 사용해도무방하다. (에디터기준)

//
