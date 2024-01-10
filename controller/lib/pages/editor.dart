import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({super.key});

  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
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
        Uri.parse("http://${Const.ssh.ip}:${Const.servicePort}/controller"),
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
          onPressed: ()  async {
            controller.runJavaScript("document.activeElement.blur();");
            await Future.delayed(const Duration(milliseconds: 700));
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Text('Editor', style: Const.titleText),
          ],
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top,
        child: WebViewWidget(controller: controller),
      ),
    );
  }
}
