import 'dart:ui_web' as ui;
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

int _bgCounter = 0;

Widget buildYoutubeBg(String videoId) {
  final viewId = 'yt-bg-${_bgCounter++}';
  ui.platformViewRegistry.registerViewFactory(viewId, (int id) {
    final wrapper = web.HTMLDivElement();
    wrapper.style.width = '100%';
    wrapper.style.height = '100%';
    wrapper.style.overflow = 'hidden';
    wrapper.style.position = 'relative';
    wrapper.style.backgroundColor = '#000';

    final iframe = web.HTMLIFrameElement();
    // Loop requires playlist param equal to the video id.
    // Extra 60px on all sides hides the YouTube UI chrome.
    iframe.src = 'https://www.youtube.com/embed/$videoId'
        '?autoplay=1&muted=1&loop=1&playlist=$videoId'
        '&controls=0&rel=0&modestbranding=1&playsinline=1'
        '&disablekb=1&fs=0&showinfo=0&iv_load_policy=3';
    iframe.style.position = 'absolute';
    iframe.style.top = '-60px';
    iframe.style.left = '-60px';
    iframe.style.width = 'calc(100% + 120px)';
    iframe.style.height = 'calc(100% + 120px)';
    iframe.style.border = 'none';
    iframe.style.pointerEvents = 'none';
    iframe.setAttribute('allow', 'autoplay; encrypted-media');

    wrapper.appendChild(iframe);
    return wrapper;
  });
  return HtmlElementView(viewType: viewId);
}
