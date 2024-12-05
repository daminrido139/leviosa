import 'dart:ui';

import 'package:flutter/material.dart';

class DrawingBoard extends StatefulWidget {
  final Widget? child;
  const DrawingBoard({
    super.key,
    this.child,
  });

  @override
  State<DrawingBoard> createState() => _DrawingBoardState();
}

class _DrawingBoardState extends State<DrawingBoard> {
  Color selectedColor = Colors.red;
  double strokeWidth = 15;
  List<DrawingPoint?> currentPoints = [];
  Widget? lastChild;

  @override
  void initState() {
    lastChild = widget.child;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (lastChild != widget.child) {
      lastChild = widget.child;
      currentPoints = [];
      setState(() {});
    }
    return GestureDetector(
      onPanStart: (details) {
        setState(() {
          currentPoints.add(
            DrawingPoint(
              details.localPosition,
              Paint()
                ..color = selectedColor
                ..isAntiAlias = true
                ..strokeWidth = strokeWidth
                ..strokeCap = StrokeCap.round,
            ),
          );
        });
      },
      onPanUpdate: (details) {
        setState(() {
          currentPoints.add(
            DrawingPoint(
              details.localPosition,
              Paint()
                ..color = selectedColor
                ..isAntiAlias = true
                ..strokeWidth = strokeWidth
                ..strokeCap = StrokeCap.round,
            ),
          );
        });
      },
      onPanEnd: (details) {
        setState(() {
          currentPoints.add(null);
        });
      },
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          const SizedBox(
            height: double.infinity,
            width: double.infinity,
          ),
          if (widget.child != null)
            SizedBox.square(dimension: 250, child: widget.child!),
          Positioned.fill(
            child: CustomPaint(
              painter: _DrawingPainter(currentPoints),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Row(
              children: [
                Slider(
                  min: 0,
                  max: 40,
                  value: strokeWidth,
                  onChanged: (val) => setState(() => strokeWidth = val),
                ),
                ElevatedButton.icon(
                  onPressed: () => setState(() => currentPoints = []),
                  icon: const Icon(Icons.clear),
                  label: const Text("Clear Board"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawingPainter extends CustomPainter {
  final List<DrawingPoint?> drawingPoints;

  _DrawingPainter(this.drawingPoints);

  List<Offset> offsetsList = [];

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < drawingPoints.length - 1; i++) {
      if (drawingPoints[i] != null && drawingPoints[i + 1] != null) {
        canvas.drawLine(drawingPoints[i]!.offset, drawingPoints[i + 1]!.offset,
            drawingPoints[i]!.paint);
      } else if (drawingPoints[i] != null && drawingPoints[i + 1] == null) {
        offsetsList.clear();
        offsetsList.add(drawingPoints[i]!.offset);

        canvas.drawPoints(
            PointMode.points, offsetsList, drawingPoints[i]!.paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class DrawingPoint {
  Offset offset;
  Paint paint;

  DrawingPoint(this.offset, this.paint);
}
