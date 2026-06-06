import 'package:flutter/material.dart';
import '_drive_image_stub.dart' if (dart.library.html) '_drive_image_web.dart';

class DriveImage extends StatefulWidget {
  final String url;
  final BoxFit fit;
  const DriveImage({required this.url, this.fit = BoxFit.cover, super.key});

  @override
  State<DriveImage> createState() => _DriveImageState();
}

class _DriveImageState extends State<DriveImage> {
  late final Widget _view;

  @override
  void initState() {
    super.initState();
    _view = buildDriveImage(widget.url, widget.fit);
  }

  @override
  Widget build(BuildContext context) => _view;
}
