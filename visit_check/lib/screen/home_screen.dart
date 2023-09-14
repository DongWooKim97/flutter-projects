import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool chooCheckDone = false;
  static final double okDistance = 100;
  static final LatLng companyLatLng = LatLng(37.5233273, 126.921252);
  static final CameraPosition initialPosition = CameraPosition(
    target: companyLatLng,
    zoom: 15,
  );

  //실제로 그릴 원을 생성한다.
  static final Circle withinDistanceCircle = Circle(
    //id값은 화면을 여러개의 원을 그렸을 때 식별할 수 있는 식별자 역할을 한다.
    circleId: CircleId('withinDistanceCircle'),
    center: companyLatLng,
    //투명도를 설정하지 않고 원을 구리면 지도를 불투명하게 가려버린다.
    fillColor: Colors.blue.withOpacity(0.5),
    //내부색칠
    radius: okDistance,
    //원의 둘레 색칠
    strokeColor: Colors.blue,
    strokeWidth: 1,
  );

  static final Circle notWithinDistanceCircle = Circle(
    //id값은 화면을 여러개의 원을 그렸을 때 식별할 수 있는 식별자 역할을 한다.
    circleId: CircleId('notWithinDistanceCircle'),
    center: companyLatLng,
    //투명도를 설정하지 않고 원을 구리면 지도를 불투명하게 가려버린다.
    fillColor: Colors.red.withOpacity(0.5),
    //내부색칠
    radius: okDistance,
    //원의 둘레 색칠
    strokeColor: Colors.red,
    strokeWidth: 1,
  );

  static final Circle checkDoneCircle = Circle(
    //id값은 화면을 여러개의 원을 그렸을 때 식별할 수 있는 식별자 역할을 한다.
    circleId: CircleId('notWithinDistanceCircle'),
    center: companyLatLng,
    //투명도를 설정하지 않고 원을 구리면 지도를 불투명하게 가려버린다.
    fillColor: Colors.green.withOpacity(0.5),
    //내부색칠
    radius: okDistance,
    //원의 둘레 색칠
    strokeColor: Colors.green,
    strokeWidth: 1,
  );

  static final Marker marker = Marker(
    markerId: MarkerId('marker'),
    position: companyLatLng,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppbar(),
      body: FutureBuilder(
        future: checkPermission(), // 무조건 Future를 리턴해주는 함수만을 사용할 수 있다.
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == '위치 권한이 허가 되었습니다.') {
            return StreamBuilder<Position>(
              stream: Geolocator.getPositionStream(), // 포지션 변경할때마다 불림.
              builder: (context, snapshot) {
                bool isWithinRange = false;

                if (snapshot.hasData) {
                  final start = snapshot.data!;
                  final end = companyLatLng;

                  final distance = Geolocator.distanceBetween(
                    start.latitude,
                    start.longitude,
                    end.latitude,
                    end.longitude,
                  );

                  if (distance < okDistance) {
                    isWithinRange = true;
                  }
                }

                return Column(
                  children: [
                    _CustomGoogleMap(
                        initialPosition: initialPosition,
                        circle: chooCheckDone
                            ? checkDoneCircle
                            : isWithinRange
                                ? withinDistanceCircle
                                : notWithinDistanceCircle,
                        marker: marker),
                    _ChoolCheckButton(
                      isWithinRange: isWithinRange,
                      choolCheckDone: chooCheckDone,
                      onPressed: onChooCheckPressed,
                    ),
                  ],
                );
              },
            );
          }
          return Center(child: Text(snapshot.data));
        },
      ),
    );
  }

  onChooCheckPressed() async {
    // 예 /아니오 기능
    // 값을 받아오고 싶으면 async로 해야된다.
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('출근하기'), // 다이얼로그창의 제목
          content: Text('출근을 하시겠습니까?'), // 다이얼로그창의 내용
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('확인'),
            ),
          ], // 실질적으로 누를 수 있는 버튼들(예/아니오)
        );
      },
    );
    if (result) {
      setState(() {
        chooCheckDone = true;
      });
    }
  }

  Future<String> checkPermission() async {
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      return '위치 서비스를 활성화 해주세요.';
    }

    LocationPermission checkedPermission = await Geolocator.checkPermission();

    if (checkedPermission == LocationPermission.denied) {
      checkedPermission = await Geolocator.requestPermission();

      if (checkedPermission == LocationPermission.denied) {
        return '위치 권한을 허가해주세요.';
      }
    }
    if (checkedPermission == LocationPermission.deniedForever) {
      return '앱의 위치 권한을 설정에서 허가해주세요.';
    }

    return '위치 권한이 허가 되었습니다.';
  }

  AppBar renderAppbar() {
    return AppBar(
      title: Text(
        '오늘도 출근',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class _CustomGoogleMap extends StatelessWidget {
  final CameraPosition initialPosition;
  final Circle circle;
  final Marker marker;

  const _CustomGoogleMap({
    required this.initialPosition,
    required this.circle,
    required this.marker,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialPosition,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        //Set이 리턴타입이기에 중복되면 하나로 인식돼서 화면에 하나만 나타난다. 결국은 화면에 동시에 띄우고 싶다면 아까 설정한 circleId를 각각 달리 설정해줘야한다.
        circles: Set.from([circle]),
        markers: Set.from([marker]),
      ),
    );
  }
}

class _ChoolCheckButton extends StatelessWidget {
  final bool isWithinRange;
  final bool choolCheckDone;
  final VoidCallback onPressed;

  const _ChoolCheckButton({
    required this.isWithinRange,
    required this.choolCheckDone,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.timelapse_outlined,
            size: 50.0,
            color: choolCheckDone
                ? Colors.green
                : isWithinRange
                    ? Colors.blue
                    : Colors.red,
          ),
          const SizedBox(
            height: 20.0,
          ),
          // 칼럼안에 대뜸 if문을 걸 수 있다 . if문 조건을 통과해야지만 아래 위젯이 나타남
          if (!choolCheckDone && isWithinRange)
            TextButton(
              onPressed: onPressed,
              child: Text('출근하기'),
            )
        ],
      ),
    );
  }
}
