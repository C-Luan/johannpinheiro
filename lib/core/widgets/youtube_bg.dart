import 'package:flutter/material.dart';
import '_youtube_bg_stub.dart' if (dart.library.html) '_youtube_bg_web.dart';

class YoutubeBg extends StatefulWidget {
  final String videoId;
  const YoutubeBg({required this.videoId, super.key});

  @override
  State<YoutubeBg> createState() => _YoutubeBgState();
}

class _YoutubeBgState extends State<YoutubeBg> {
  late final Widget _view;

  @override
  void initState() {
    super.initState();
    _view = buildYoutubeBg(widget.videoId);
  }

  @override
  Widget build(BuildContext context) => _view;
}
