import 'package:flutter/material.dart';

class TextWithWhiteShadow extends StatelessWidget {
  final String text;
  final double fontSize;
  final String align;
  final double? height;
  final bool applySoftWrap;
  final bool fontFamily;

  const TextWithWhiteShadow({
    super.key,
    required this.text,
    required this.fontSize,
    this.align = "",
    this.height,
    this.applySoftWrap = false,
    this.fontFamily = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align == "right"
          ? TextAlign.right
          : align == "left"
              ? TextAlign.left
              : align == "center"
                  ? TextAlign.center
                  : null,
      softWrap: applySoftWrap,
      overflow: applySoftWrap ? TextOverflow.visible : TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: fontFamily ? Icons.arrow_upward.fontFamily : null,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        height: height,
        shadows: const [
          Shadow(
            color: Colors.white,
            offset: Offset(0, 0),
            blurRadius: 10,
          ),
          Shadow(
            color: Colors.white,
            offset: Offset(2, 2),
            blurRadius: 10,
          ),
          Shadow(
            color: Colors.white,
            offset: Offset(-2, -2),
            blurRadius: 10,
          ),
          Shadow(
            color: Colors.white,
            offset: Offset(2, -2),
            blurRadius: 10,
          ),
          Shadow(
            color: Colors.white,
            offset: Offset(-2, 2),
            blurRadius: 10,
          ),
        ],
      ),
    );
  }
}
