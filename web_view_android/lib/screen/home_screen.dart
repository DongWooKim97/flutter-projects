import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Code Factory'),
        centerTitle: true,
      ),
      body: WebView(
        // initialUrl : 웹뷰가 실행되면 초기에 어떤 화면을 띄울거냐 하는 것
        initialUrl: 'https://blog.codefactory.ai',
        // javascriptMode : 웹뷰에선 자바스크립트모드가 디폴트로 꺼져있음.
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
