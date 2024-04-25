import 'package:flutter/material.dart';
import '../style/color-palette.dart';

class Logo extends StatefulWidget {
  @override
  _LogoState createState() => _LogoState();
}

class _LogoState extends State<Logo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    )..repeat(reverse: true);
    _offsetAnimation = Tween<Offset>(
      begin: Offset(-0.3, 0),
      end: Offset(0.3, 0),
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth * 0.1; // Adjust this factor as needed

    return SlideTransition(
      position: _offsetAnimation,
      child: CustomPaint(
        painter: DarthFlutterPainter(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Darth Flutter',
            style: TextStyle(
              color: ColorPalette.clouds,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class DarthFlutterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = ColorPalette.pomegranate
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromLTRB(0, 0, size.width, size.height);
    final radius = Radius.circular(40.0);
    final roundedRect = RRect.fromRectAndCorners(rect,
        topLeft: radius, topRight: radius, bottomLeft: radius, bottomRight: radius);

    canvas.drawRRect(roundedRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

