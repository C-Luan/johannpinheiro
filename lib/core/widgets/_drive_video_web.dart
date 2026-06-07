import 'dart:ui_web' as ui;
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

int _videoCounter = 0;

Widget buildDriveVideo(String embedUrl) {
  final viewId = 'drive-video-${_videoCounter++}';
  ui.platformViewRegistry.registerViewFactory(
    viewId,
    (int id) {
      final iframe = web.HTMLIFrameElement();
      iframe.src = embedUrl;
      iframe.style.width = '100%';
      iframe.style.height = '100%';
      iframe.style.border = 'none';
      iframe.allowFullscreen = true;
      iframe.setAttribute('allow', 'autoplay; encrypted-media; fullscreen');
      return iframe;
    },
  );
  return HtmlElementView(viewType: viewId);
}
