import 'package:flutter/material.dart';

class DetailRectangle extends StatelessWidget {
  final String position;
  final String primaryColor;
  final String secondaryColor;

  const DetailRectangle({
    super.key,
    required this.position,
    required this.primaryColor,
    required this.secondaryColor,
  });

  List<Color> _getColorGradient(String colorName) {
    switch (colorName) {
      case "black":
        return [
          Colors.grey.shade900,
          Colors.grey.shade800,
          Colors.grey.shade700,
          Colors.grey.shade800,
          Colors.grey.shade900,
        ];
      case "blue":
        return [
          Colors.blue.shade900,
          Colors.blue.shade700,
          Colors.blue.shade400,
          Colors.blue.shade700,
          Colors.blue.shade900,
        ];
      case "green":
        return [
          Colors.green.shade900,
          Colors.green.shade700,
          Colors.green.shade400,
          Colors.green.shade700,
          Colors.green.shade900,
        ];
      case "grey":
        return [
          Colors.grey.shade700,
          Colors.grey.shade600,
          Colors.grey.shade500,
          Colors.grey.shade600,
          Colors.grey.shade700,
        ];
      case "orange":
        return [
          Colors.orange.shade900,
          Colors.orange.shade700,
          Colors.orange.shade500,
          Colors.orange.shade700,
          Colors.orange.shade900,
        ];
      case "pink":
        return [
          Colors.pink.shade700,
          Colors.pink.shade500,
          Colors.pink.shade400,
          Colors.pink.shade500,
          Colors.pink.shade700,
        ];
      case "purple":
        return [
          Colors.purple.shade800,
          Colors.purple.shade600,
          Colors.purple.shade400,
          Colors.purple.shade600,
          Colors.purple.shade800,
        ];
      case "red":
        return [
          Colors.red.shade900,
          Colors.red.shade700,
          Colors.red.shade400,
          Colors.red.shade700,
          Colors.red.shade900,
        ];
      case "yellow":
        return [
          Colors.yellow.shade800,
          Colors.yellow.shade600,
          Colors.yellow.shade400,
          Colors.yellow.shade600,
          Colors.yellow.shade800,
        ];
      case "white":
        return [
          Colors.grey.shade100,
          Colors.grey.shade50,
          Colors.white,
          Colors.grey.shade50,
          Colors.grey.shade100,
        ];
      default:
        return [Colors.black];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: position == "left"
            ? const EdgeInsets.only(left: 0, top: 0, right: 50)
            : const EdgeInsets.only(left: 50, bottom: 0, right: 0),
          height: 60,
          child: ClipPath(
            clipper: position == "left"
              ? InvertedDiagonalClipper(breakSizeTop: 30, breakSizeBottom: 0, position: position)
              : InvertedDiagonalClipper(breakSizeTop: 0, breakSizeBottom: 30, position: position),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _getColorGradient(primaryColor),
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: position == "left"
            ? const EdgeInsets.only(left: 0, top: 0, right: 100)
            : const EdgeInsets.only(left: 100, top: 40, right: 0),
          height: 20,
          child: ClipPath(
            clipper: position == "left"
              ? InvertedDiagonalClipper(breakSizeTop: 8, breakSizeBottom: 0, position: position)
              : InvertedDiagonalClipper(breakSizeTop: 0, breakSizeBottom: 8, position: position),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _getColorGradient(secondaryColor),
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
  final String position;
  const InvertedDiagonalClipper({required this.breakSizeTop, required this.breakSizeBottom, required this.position});

  @override
  Path getClip(Size size) {
    Path path = Path();
    if(position == 'left') {
      path.lineTo(size.width - breakSizeTop, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(breakSizeBottom, size.height);
    }
    else {
      path.lineTo(size.width, breakSizeTop);
      path.lineTo(size.width, size.height);
      path.lineTo(breakSizeBottom, size.height);
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
