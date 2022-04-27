import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CameraWidget extends StatefulWidget {
  final String title;

  const CameraWidget({Key? key, required this.title}) : super(key: key);

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Camera: ${widget.title}")
      ),
      body: const WebView(
        initialUrl: "https://www.youtube.com",
      ),
    );
  }
}
