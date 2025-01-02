import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class StylishScaffold extends StatelessWidget {
  final String title;
  final Widget child;

  const StylishScaffold({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: AutoSizeText(
          title,
          maxLines: 1,
        ),
        forceMaterialTransparency: true,
      ),
      body: _StylishBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: child,
        ),
      ),
    );
  }
}

//region _StylishBackground
class _StylishBackground extends StatelessWidget {
  final Widget child;

  const _StylishBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SizedBox.fromSize(
      size: screenSize,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: CustomPaint(
              painter: _HalfOvalPainter(colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).colorScheme.onPrimary,
              ]),
              child: SizedBox(
                height: screenSize.height / 2,
                width: screenSize.width,
              ),
            ),
          ),
          SafeArea(child: child),
        ],
      ),
    );
  }
}
//endregion

//region _HalfOvalPainter
class _HalfOvalPainter extends CustomPainter {
  final List<Color> colors;

  _HalfOvalPainter({super.repaint, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    // relativeQuadraticBezierTo(double controlX, double controlY, double endX, double endY)
    final p = Path()
      ..lineTo(0, size.height / 2)
      ..relativeQuadraticBezierTo(size.width / 2, size.height / 5, size.width, 0)
      ..lineTo(size.width, 0)
      ..close();

    final shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: colors,
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(p, Paint()..shader = shader);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
//endregion
