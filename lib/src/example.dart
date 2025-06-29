/*import 'dart:math';

import 'package:dastranj_infrastructure/dastranj_infrastructure.dart';
import 'package:flutter/material.dart';

class EmployeeLoanRequestRemainIndicator extends StatelessWidget {

  const EmployeeLoanRequestRemainIndicator({
    required this.totalAmount,
    required this.remainAmount,
    this.successBound = 90,
    this.warningBound = 135,
    super.key,
  }) : assert(
          remainAmount <= totalAmount ||
              warningBound > successBound ||
              successBound > 0 ||
              warningBound > 0 ||
              successBound < 180 ||
              warningBound < 180,
          "Remaining days can't be more than total days",
        );
  final int totalAmount, remainAmount, successBound, warningBound;

  @override
  Widget build(final BuildContext context) => AspectRatio(
        aspectRatio: 1,
        child: CustomPaint(
          painter: MyCustomPainter(
            context,
            remainDay: remainAmount,
            totalDay: totalAmount,
            successBound: successBound,
            warningBound: warningBound,
          ),
        ),
      );
}

class MyCustomPainter extends CustomPainter {

  MyCustomPainter(
    this.context, {
    required this.totalDay,
    required this.remainDay,
    required this.successBound,
    required this.warningBound,
  });

  final BuildContext context;
  final int totalDay, remainDay, successBound, warningBound;

  @override
  bool shouldRepaint(final MyCustomPainter oldDelegate) => true;

  @override
  void paint(final Canvas canvas, final Size size) {
    final circleCenterX = size.width / 2;
    final circleCenterY = 2 * size.height / 3;
    final circleRadius = size.width / 2;

    final Rect rect = Rect.fromCircle(
      center: Offset(circleCenterX, circleCenterY),
      radius: circleRadius,
    );

    _drawArcs(canvas, rect);

    final int remainDegree = ((totalDay - remainDay) / totalDay * 180).round();
    final int pointDegree = remainDegree - 180;

    _drawPoint(
      centerX: circleCenterX,
      radius: circleRadius,
      centerY: circleCenterY,
      canvas: canvas,
      angleDegree: pointDegree,
      color: _getPointColor(pointDegree),
      backgroundColor: context.styleData.backgroundColor,
    );
  }

  void _drawPoint({
    required double centerX,
    required double radius,
    required double centerY,
    required Canvas canvas,
    required Color color,
    required int angleDegree,
    required Color backgroundColor,
  }) {
    const pointRadius = 5.0;
    final pointPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final blackPointPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final angle = _degreesToRadians(angleDegree);
    final pointX = centerX + radius * cos(angle);
    final pointY = centerY + radius * sin(angle);

    canvas.drawCircle(Offset(pointX, pointY), pointRadius, pointPaint);
    canvas.drawCircle(Offset(pointX, pointY), 2, blackPointPaint);
  }

  void _drawArcs(Canvas canvas, Rect rect) {
    canvas.drawArc(
      rect,
      _degreesToRadians(-180),
      _degreesToRadians(successBound),
      false,
      _getPaint(context.styleData.successColor),
    );

    canvas.drawArc(
      rect,
      _degreesToRadians(-180 + successBound),
      _degreesToRadians(warningBound - successBound),
      false,
      _getPaint(context.styleData.warningColor),
    );

    canvas.drawArc(
      rect,
      _degreesToRadians(-180 + warningBound),
      _degreesToRadians(180 - warningBound),
      false,
      _getPaint(context.styleData.dangerColor),
    );
  }

  Paint _getPaint(final Color color) => Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeWidth = 5;

  Color _getPointColor(final int degree) {
    final int positiveDegree = degree + 180;
    if (positiveDegree >= 0 && positiveDegree < successBound) {
      return context.styleData.successColor;
    } else if (positiveDegree >= successBound &&
        positiveDegree < warningBound) {
      return context.styleData.warningColor;
    } else {
      return context.styleData.dangerColor;
    }
  }

  double _degreesToRadians(final int degrees) => degrees * (pi / 180);
}
*/