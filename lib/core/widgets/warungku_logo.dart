
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class WarungkuLogo extends StatelessWidget {
  final double width;

  const WarungkuLogo({
    super.key,
    this.width = 120,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: width * 0.78,
      child: CustomPaint(
        painter: _WarungkuLogoPainter(),
      ),
    );
  }
}

class _WarungkuLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width / 150, size.height / 117);

    final wallPaint = Paint()
      ..color = AppColors.storeWall;

    final outlinePaint = Paint()
      ..color = AppColors.outline
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Badan toko
    final wall = RRect.fromRectAndRadius(
      const Rect.fromLTWH(12, 37, 126, 76),
      const Radius.circular(3),
    );

    canvas.drawRRect(wall, wallPaint);
    canvas.drawRRect(wall, outlinePaint);

    // Atap toko
    final roof = Path()
      ..moveTo(18, 13)
      ..lineTo(132, 13)
      ..lineTo(148, 31)
      ..lineTo(2, 31)
      ..close();

    canvas.drawPath(
      roof,
      Paint()..color = AppColors.roof,
    );

    // Kanopi
    for (int i = 0; i < 5; i++) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(2 + i * 29.2, 31, 29.5, 27),
          const Radius.circular(12),
        ),
        Paint()..color = AppColors.primary,
      );
    }

    // Jendela
    final window = RRect.fromRectAndRadius(
      const Rect.fromLTWH(22, 60, 65, 39),
      const Radius.circular(1),
    );

    canvas.drawRRect(
      window,
      Paint()..color = AppColors.window,
    );
    canvas.drawRRect(window, outlinePaint);

    // Pantulan kaca
    final reflection = Path()
      ..moveTo(47, 62)
      ..lineTo(61, 62)
      ..lineTo(37, 97)
      ..lineTo(26, 97)
      ..close();

    canvas.drawPath(
      reflection,
      Paint()..color = const Color(0xFF72B5FF),
    );

    // Pintu
    final door = RRect.fromRectAndRadius(
      const Rect.fromLTWH(101, 60, 27, 39),
      const Radius.circular(1),
    );

    canvas.drawRRect(
      door,
      Paint()..color = AppColors.door,
    );
    canvas.drawRRect(door, outlinePaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
