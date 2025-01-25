import 'package:flutter/material.dart';

class DetailRectangleRight extends StatelessWidget {
  const DetailRectangleRight({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 50, bottom: 0, right: 0),
          height: 60,
          child: ClipPath(
            clipper: const InvertedDiagonalClipper(breakSizeTop: 0, breakSizeBottom: 30),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.red.shade900,
                    Colors.red.shade700,
                    Colors.red.shade400,
                    Colors.red.shade700,
                    Colors.red.shade900,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 100, top: 40, right: 0),
          height: 20,
          child: ClipPath(
            clipper: const InvertedDiagonalClipper(breakSizeTop: 0, breakSizeBottom: 8),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade900,
                    Colors.blue.shade700,
                    Colors.blue.shade400,
                    Colors.blue.shade700,
                    Colors.blue.shade900,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class InvertedDiagonalClipper extends CustomClipper<Path> {
  final double breakSizeTop;
  final double breakSizeBottom;
  const InvertedDiagonalClipper({required this.breakSizeTop, required this.breakSizeBottom});

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, breakSizeTop);
    path.lineTo(size.width, size.height);
    path.lineTo(breakSizeBottom, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
