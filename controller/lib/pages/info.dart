import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../constants/constants.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  String _markdownData = '';

  @override
  void initState() {
    super.initState();
    loadMarkdown();
  }

  Future<void> loadMarkdown() async {
    final markdownContent = await rootBundle.loadString('assets/README.md');
    setState(() {
      _markdownData = markdownContent;
    });
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
            Text('Info', style: Const.titleText),
          ],
        ),
      ),
      body: _markdownData.isNotEmpty
          ? Markdown(data: _markdownData)
          : Center(child: CircularProgressIndicator()),
    );
  }
}
