import 'dart:ui_web' as ui;
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

int _viewCounter = 0;

Widget buildDriveImage(String url, BoxFit fit) {
  final viewId = 'drive-img-${_viewCounter++}';
  ui.platformViewRegistry.registerViewFactory(
    viewId,
    (int id) {
      final img = web.HTMLImageElement();
      img.src = url;
      img.style.objectFit = fit == BoxFit.cover ? 'cover' : 'contain';
      img.style.width = '100%';
      img.style.height = '100%';
      return img;
    },
  );
  return HtmlElementView(viewType: viewId);
}
