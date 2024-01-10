import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constants/constants.dart';

class GithubPage extends StatefulWidget {
  const GithubPage({super.key});

  @override
  _GithubPageState createState() => _GithubPageState();
}

class _GithubPageState extends State<GithubPage> {
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
        Uri.parse("https://github.com/0xbaggi/scroll_text_application"),
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
          onPressed: () async {
            controller.runJavaScript("document.activeElement.blur();");
            await Future.delayed(const Duration(milliseconds: 800));
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Text('Github', style: Const.titleText),
          ],
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
