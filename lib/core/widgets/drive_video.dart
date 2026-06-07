import 'package:flutter/material.dart';
import '_drive_video_stub.dart' if (dart.library.html) '_drive_video_web.dart';

class DriveVideo extends StatefulWidget {
  final String embedUrl;
  const DriveVideo({required this.embedUrl, super.key});

  @override
  State<DriveVideo> createState() => _DriveVideoState();
}

class _DriveVideoState extends State<DriveVideo> {
  late final Widget _view;

  @override
  void initState() {
    super.initState();
    _view = buildDriveVideo(widget.embedUrl);
  }

  @override
  Widget build(BuildContext context) => _view;
}
