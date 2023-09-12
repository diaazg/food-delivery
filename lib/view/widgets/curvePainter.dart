import 'package:flutter/material.dart';
import 'package:food/constant/Style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    // TODO: Set properties to paint
    paint.color = MyColor().mainColor;
    paint.style = PaintingStyle.fill;

    var path = Path();

    // TODO: Draw your path
    path.moveTo(0, 320.h);
    path.quadraticBezierTo(size.width * 0.5, 370.h, size.width , 320.h);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}