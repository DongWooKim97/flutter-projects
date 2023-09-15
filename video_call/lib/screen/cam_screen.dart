import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_call/const/agora.dart';

class CamScreen extends StatefulWidget {
  const CamScreen({Key? key}) : super(key: key);

  @override
  State<CamScreen> createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  int? uid = 0; // 화상 채팅 채널에 접속한 나의 아이디
  int? otherUid; // 화상 채팅 채널에 접속한 상대 아이디
  RtcEngine? engine;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LIVE'),
      ),
      body: FutureBuilder<bool>(
        future: init(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    renderMainView(),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        color: Colors.grey,
                        height: 160,
                        width: 120,
                        child: renderSubView(),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await engine!.leaveChannel();
                    engine = null;
                  },
                  child: Text('채널 나가기'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  renderMainView() {
    if (uid == null) {
      return Center(
        child: Text('채널에 참여해주세요.'),
      );
    } else {
      return AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: engine!,
          canvas: VideoCanvas(
            uid: 0,
          ),
        ),
      );
    }
  }

  renderSubView() {
    if (otherUid == null) {
      return Center(
        child: Text(
          '채널에 유저가 없습니다.',
        ),
      );
    } else {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: engine!,
          canvas: VideoCanvas(uid: otherUid),
          connection: RtcConnection(channelId: CHANNEL_NAME),
        ),
      );
    }
  }

  //카메라와 마이크를 요청하는 함수를 생성!
  Future<bool> init() async {
    final resp = await [Permission.camera, Permission.microphone].request();

    final cameraPermission = resp[Permission.camera];
    final microphonePermission = resp[Permission.microphone];

    if (cameraPermission != PermissionStatus.granted ||
        microphonePermission != PermissionStatus.granted) {
      throw '카메라 또는 마이크 권한이 없습니다.';
    }

    if (engine == null) {
      engine = createAgoraRtcEngine();
      await engine!.initialize(
        RtcEngineContext(
          appId: APP_ID,
        ),
      );

      //4가지의 이벤트 발생 예시
      engine!.registerEventHandler(
        RtcEngineEventHandler(
          // 내가 채널에 입장했을 때
          // connection -> 연결정보
          // elapsed -> 연결된 시간 (연결된지 얼마나 됐는지)
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            print('채널에 입장했습니다., uid: ${connection.localUid}');
            setState(() {
              uid = connection.localUid;
            });
          },
          // 내가 채널에서 나갔을 때
          onLeaveChannel: (RtcConnection connection, RtcStats stats) {
            print('채널 퇴장');
            setState(() {
              uid == null;
            });
          },
          //상대방 유저가 채널에 들어왔을 때
          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
            print('상대가 채널에 입장했습니다. otherUid: $remoteUid');
            setState(() {
              otherUid = remoteUid;
            });
          },
          // 상대가 채널에서 나갔을 때
          onUserOffline: (RtcConnection connection, int remoteUid,
              UserOfflineReasonType reason) {
            print('상대가 채널에서 나갔습니다. otherUid: $remoteUid');
            setState(() {
              otherUid = null;
            });
          },
        ),
      );
      await engine!.enableVideo();
      await engine!.startPreview();

      ChannelMediaOptions options = ChannelMediaOptions();
      await engine!.joinChannel(
        token: TEMP_TOKEN,
        channelId: CHANNEL_NAME,
        uid: 0,
        options: options,
      );
    }
    return true;
  }
}
