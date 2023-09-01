import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget {

  WebViewController? controller;
  final homeUrl = 'https://blog.codefactory.ai';

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Code Factory'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            if(controller == null) {
              return;
            }
            controller!.loadUrl(homeUrl);
          }, icon: Icon(
            Icons.home
          ))
        ],
      ),
      body: WebView(
        // onWebViewCreated -> 웹뷰가 생성되었을 때 하는 행동. 우리는 class내에 WebviewController를 따로 빼서 관리.
        onWebViewCreated: (WebViewController controller){
          this.controller = controller;
        },
        // initialUrl : 웹뷰가 실행되면 초기에 어떤 화면을 띄울거냐 하는 것
        initialUrl: homeUrl,
        // javascriptMode : 웹뷰에선 자바스크립트모드가 디폴트로 꺼져있음.
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
