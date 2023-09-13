import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final XFile video;
  final VoidCallback onNewVideoPressed;

  const CustomVideoPlayer({
    required this.video,
    required this.onNewVideoPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? videoController;
  Duration currentPosition = Duration();
  bool showControls = false;

  @override // initState는 무조건 State가 생성될 때 딱 한번만 실행된다!!
  void initState() {
    super.initState();
    initializeController();
  }

  // StatefulWidget이 실행된 이력이 있는데(=initState는 이미 실행돼서 더 이상 실행될 수 없는 상황),
  // StatefulWidget에서 파라미터만 변경되었을 때 사용가능하다.
  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.video.path != widget.video.path) {
      initializeController();
    }
  }

  initializeController() async {
    currentPosition = Duration(); // 다시 값을 0으로 (영상시작으로) 돌림.

    videoController = VideoPlayerController.file(
      File(widget.video.path),
    );

    await videoController!.initialize();

    videoController!.addListener(() {
      // 비디오컨트롤러가 (현재)값이 변경될 때 마다 리스너 실행
      final currentPosition = videoController!.value.position;
      setState(() {
        this.currentPosition = currentPosition;
      });
    });

    setState(() {});
  }

  void onLeftPressed() {
    final currentPosition = videoController!.value.position; // 현재위치

    Duration position = Duration(); // 디폴트는 0초

    if (currentPosition.inSeconds > 3) {
      position = currentPosition - Duration(seconds: 3);
    }

    videoController!.seekTo(position); // 이동할 위치 설정
  }

  void onPlayPressed() {
    // 이미 실행중이면 중지 , 중지일땐 실행
    setState(() {
      if (videoController!.value.isPlaying) {
        videoController!.pause();
      } else {
        videoController!.play();
      }
    });
  }

  void onRightPressed() {
    final maxPosition = videoController!.value.duration;
    final currentPosition = videoController!.value.position; // 현재위치

    Duration position = maxPosition; // 최대 길이는 비디오의 영상길이로

    if ((maxPosition - Duration(seconds: 3)).inSeconds >
        currentPosition.inSeconds) {
      position = currentPosition + Duration(seconds: 3);
    }

    videoController!.seekTo(position); // 이동할 위치 설정
  }

  @override
  Widget build(BuildContext context) {
    if (videoController == null) {
      return CircularProgressIndicator();
    }

    return AspectRatio(
      aspectRatio: videoController!.value.aspectRatio, // 원래 비율대로 넣어야함
      child: GestureDetector(
        onTap: () {
          setState(() {
            showControls = !showControls;
          });
        },
        child: Stack(
          children: [
            VideoPlayer(
              videoController!,
            ),
            if (showControls)
              _Controls(
                onLeftPressed: onLeftPressed,
                onPlayPressed: onPlayPressed,
                onRightPressed: onRightPressed,
                isPlaying: videoController!.value.isPlaying,
              ),
            if (showControls)
              _NewVideo(
                onPressed: widget.onNewVideoPressed,
              ),
            _SliderBottom(
              currentPosition: currentPosition,
              maxPosition: videoController!.value.duration,
              onSliderChanged: onSliderChanged,
            )
          ],
        ),
      ),
    );
  }

  void onSliderChanged(double val) {
    videoController!.seekTo(
      Duration(
        seconds: val.toInt(),
      ),
    );
  }
}

class _Controls extends StatelessWidget {
  final VoidCallback onPlayPressed;
  final VoidCallback onLeftPressed;
  final VoidCallback onRightPressed;
  final bool isPlaying;

  const _Controls({
    required this.onLeftPressed,
    required this.onPlayPressed,
    required this.onRightPressed,
    required this.isPlaying,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      height: MediaQuery.of(context).size.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          renderIconButton(
            onPressed: onLeftPressed,
            iconData: Icons.rotate_left,
          ),
          renderIconButton(
            onPressed: onPlayPressed,
            iconData: isPlaying ? Icons.pause : Icons.play_arrow,
          ),
          renderIconButton(
            onPressed: onRightPressed,
            iconData: Icons.rotate_right,
          ),
        ],
      ),
    );
  }

  Widget renderIconButton({
    required VoidCallback onPressed,
    required IconData iconData,
  }) {
    return IconButton(
      onPressed: onPressed,
      iconSize: 30.0,
      color: Colors.white,
      icon: Icon(
        iconData,
      ),
    );
  }
}

class _NewVideo extends StatelessWidget {
  final VoidCallback onPressed;

  const _NewVideo({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0, // 오른쪽 0만큼의 포지션에 위치.
      child: IconButton(
        color: Colors.white,
        iconSize: 30.0,
        onPressed: onPressed,
        icon: Icon(
          Icons.photo_camera_back,
        ),
      ),
    );
  }
}

class _SliderBottom extends StatelessWidget {
  final Duration currentPosition;
  final Duration maxPosition;
  final ValueChanged<double> onSliderChanged;

  const _SliderBottom({
    required this.currentPosition,
    required this.maxPosition,
    required this.onSliderChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Text(
              '${currentPosition.inMinutes}:${(currentPosition.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Slider(
                value: currentPosition.inSeconds.toDouble(),
                onChanged: onSliderChanged,
                max: maxPosition.inSeconds.toDouble(),
                min: 0,
              ),
            ),
            Text(
              '${maxPosition.inMinutes}:${(maxPosition.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 새로운 위젯들을 사용하기 위해선 스택을 이용해야함.
// 컨트롤(스택에 있는 위젯들)이 뜨면은 뒤에 배경색을 조금 어둡게 처리헤줘야 컨트롤들이 잘 보임

// 컨트롤러에는 리스너를 달 수 있다.
// 슬라이더로 움직일 때 동영상을 조절할 수 있어야 한다.

// 컨트롤러에 들어간 노브는 우리가 컨트롤러의 현재값을 가지고만 움직이고 있었다.
// 그런데, 이 값은 컨트롤러가 값이 바꼈을 때마다 그 값을 가지고 오고 있다.
// 이거 이해하기 좀 어렵다. 노브를 우리가 직접 움직일 때 onChanged가 매번 실행되고 움직이는 방향대로 비디오 컨트롤러가 움직이라고
// 값을 다시 가져다 줘야하기 때문.
