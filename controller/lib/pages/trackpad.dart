import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TrackpadPage extends StatefulWidget {
  const TrackpadPage({super.key});

  @override
  _TrackpadPageState createState() => _TrackpadPageState();
}

class _TrackpadPageState extends State<TrackpadPage> {
  late final WebViewController controller;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
        ),
      )
      ..loadRequest(
        Uri.parse("http://${Const.ssh.ip}:${Const.servicePort}/trackpad"),
      );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Const.darkGrey,
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 24,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Text('Trackpad', style: Const.titleText),
          ],
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
