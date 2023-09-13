import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final XFile video;

  const CustomVideoPlayer({
    required this.video,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? videoController;

  @override
  void initState() {
    super.initState();
    initializeController();
  }

  initializeController() async {
    videoController = VideoPlayerController.file(
      File(widget.video.path),
    );

    await videoController!.initialize();
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
      child: Stack(
        children: [
          VideoPlayer(
            videoController!,
          ),
          _Controls(
            onLeftPressed: onLeftPressed,
            onPlayPressed: onPlayPressed,
            onRightPressed: onRightPressed,
            isPlaying: videoController!.value.isPlaying,
          ),
          Positioned(
            right: 0, // 오른쪽 0만큼의 포지션에 위치.
            child: IconButton(
              color: Colors.white,
              iconSize: 30.0,
              onPressed: () {},
              icon: Icon(
                Icons.photo_camera_back,
              ),
            ),
          )
        ],
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          renderIconButton(
              onPressed: onLeftPressed, iconData: Icons.rotate_left),
          renderIconButton(
            onPressed: onPlayPressed,
            iconData: isPlaying ? Icons.pause : Icons.play_arrow,
          ),
          renderIconButton(
              onPressed: onRightPressed, iconData: Icons.rotate_right),
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

// 새로운 위젯들을 사용하기 위해선 스택을 이용해야함.
// 컨트롤(스택에 있는 위젯들)이 뜨면은 뒤에 배경색을 조금 어둡게 처리헤줘야 컨트롤들이 잘 보임
