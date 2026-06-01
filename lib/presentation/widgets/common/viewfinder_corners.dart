import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Draws gold L-shaped viewfinder corners around its child.
class ViewfinderCorners extends StatelessWidget {
  final Widget child;
  final double armLength;
  final double strokeWidth;
  final double padding;

  const ViewfinderCorners({
    super.key,
    required this.child,
    this.armLength  = 24,
    this.strokeWidth = 1.2,
    this.padding    = 16,
  });

  @override
  Widget build(BuildContext context) => Stack(
        clipBehavior: Clip.none,
        children: [
          child,
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _CornerPainter(
                  armLength:   armLength,
                  strokeWidth: strokeWidth,
                  padding:     padding,
                ),
              ),
            ),
          ),
        ],
      );
}

class _CornerPainter extends CustomPainter {
  final double armLength;
  final double strokeWidth;
  final double padding;

  const _CornerPainter({
    required this.armLength,
    required this.strokeWidth,
    required this.padding,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.gold.withAlpha(204) // 80 %
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    final l = -padding;       // left / top offset (outside)
    final r = size.width  + padding; // right offset
    final b = size.height + padding; // bottom offset
    final a = armLength;

    // Top-left
    _corner(canvas, paint, Offset(l, l + a), Offset(l, l), Offset(l + a, l));
    // Top-right
    _corner(canvas, paint, Offset(r - a, l), Offset(r, l), Offset(r, l + a));
    // Bottom-left
    _corner(canvas, paint, Offset(l, b - a), Offset(l, b), Offset(l + a, b));
    // Bottom-right
    _corner(canvas, paint, Offset(r - a, b), Offset(r, b), Offset(r, b - a));
  }

  void _corner(Canvas c, Paint p, Offset a, Offset corner, Offset b) {
    c.drawLine(a, corner, p);
    c.drawLine(corner, b, p);
  }

  @override
  bool shouldRepaint(_CornerPainter old) =>
      old.armLength != armLength ||
      old.strokeWidth != strokeWidth ||
      old.padding != padding;
}
