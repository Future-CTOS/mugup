import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class Shayan extends StatefulWidget {
  const Shayan({super.key});

  @override
  State<Shayan> createState() => _ShayanState();
}

class _ShayanState extends State<Shayan> {
  final List<Offset> points = [
    Offset(100, 100),
    Offset(200, 200),
    Offset(300, 300),
  ];

  final List<Color> colorList = Colors.accents;
  final GlobalKey _repaintKey = GlobalKey();
  Color selectedColor = Colors.red;
  double brushSize = 20;

  bool useBlur = false;
  bool isLoading = false;

  Future<String?> _exportDrawing() async {
    try {
      final RenderRepaintBoundary? boundary =
          _repaintKey.currentContext?.findRenderObject()
              as RenderRepaintBoundary?;
      if (boundary == null) {
        print('boundary is not ready');
        return null;
      }
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      final Uint8List? pngBytes = byteData?.buffer.asUint8List();

      final directory = await getApplicationDocumentsDirectory();
      final String filePath =
          '${directory.path}/drawing_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File(filePath);
      await file.writeAsBytes(pngBytes!);
      print('Image saved to $filePath');
      print('the  length  of  png is:${pngBytes.length}');
      return filePath;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  // Future<void> _downloadWebImage({
  //   required Uint8List pngBytes,
  //   required String fileName,
  // }) async {
  //   final blob = html.Blob(pngBytes);
  // }
  //
  // void downloadImageWeb(Uint8List pngBytes, String filename) {
  //   final blob = html.Blob([pngBytes]);
  //   final url = html.Url.createObjectUrlFromBlob(blob);
  //   final anchor = html.AnchorElement(href: url)
  //     ..setAttribute('download', filename)
  //     ..click();
  //   html.Url.revokeObjectUrl(url);
  // }

  Future<void> _shareDrawing() async {
    final path = await _exportDrawing();
    if (path != null) {
      await SharePlus.instance.share(
        ShareParams(
          previewThumbnail: XFile(path),
          text: 'Check out my drawing!',
        ),
      );
    }
  }

  Future<void> _previewDrawing(BuildContext context) async {
    final String? path = await _exportDrawing();
    if (context.mounted && path != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PreviewPage(imagePath: path)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Paint paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = brushSize
          ..style = PaintingStyle.stroke
          ..maskFilter = useBlur ? MaskFilter.blur(BlurStyle.normal, 8) : null
          ..color = selectedColor;

    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onPanUpdate:
                    (details) => setState(() {
                      points.add(details.localPosition);
                    }),
                onPanStart:
                    (details) =>
                        setState(() => points.add(details.localPosition)),
                child: RepaintBoundary(
                  key: _repaintKey,
                  child: CustomPaint(
                    painter: ShayanPaint(
                      customPaint: paint,
                      points: points,
                      brushSize: brushSize,
                    ),
                    child: SizedBox.expand(),
                  ),
                ),
              ),
            ),
            Wrap(
              children:
                  colorList.map((e) {
                    return GestureDetector(
                      onTap: () => setState(() => selectedColor = e),
                      child: Container(
                        margin: EdgeInsets.all(4),
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: e,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:
                                selectedColor == e
                                    ? Colors.black
                                    : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
            Slider(
              min: 1,
              max: 200,
              value: brushSize,
              label: brushSize.toString(),
              activeColor: selectedColor,
              onChanged: (value) => setState(() => brushSize = value),
            ),
            Switch(
              value: useBlur,
              onChanged: (value) => setState(() => useBlur = value),
            ),
            IconButton(onPressed: _shareDrawing, icon: Icon(Icons.share)),

            IconButton(
              onPressed: () => _previewDrawing(context),
              icon: Icon(Icons.image),
            ),
          ],
        ),
      ),
    );
  }
}

class ShayanPaint extends CustomPainter {
  ShayanPaint({
    required this.customPaint,
    required this.points,
    required this.brushSize,
  });

  final Paint customPaint;
  final List<Offset> points;
  final double brushSize;

  @override
  void paint(Canvas canvas, Size size) {
    for (final element in points) {
      canvas.drawCircle(element, brushSize / 2, customPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class PreviewPage extends StatelessWidget {
  const PreviewPage({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('Preview')),
    body: Image.file(File(imagePath)),
  );
}
