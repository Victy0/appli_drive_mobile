import 'package:flutter/material.dart';

class TextWithWhiteShadow extends StatelessWidget {
  final String text;
  final double fontSize;
  final String align;
  final double? height;
  final bool applySoftWrap;
  final bool fontFamily;
  final Color textColor;
  final double outlineWidth;

  const TextWithWhiteShadow({
    super.key,
    required this.text,
    required this.fontSize,
    this.align = "left",
    this.height,
    this.applySoftWrap = false,
    this.fontFamily = false,
    this.textColor = Colors.black,
    this.outlineWidth = 9.0,
  });

  TextAlign? get _textAlign {
    switch (align) {
      case "right":
        return TextAlign.right;
      case "left":
        return TextAlign.left;
      case "center":
        return TextAlign.center;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final font = fontFamily ? Icons.arrow_upward.fontFamily : null;

    return Stack(
      children: [
        // Contorno branco
        Text(
          text,
          textAlign: _textAlign,
          softWrap: applySoftWrap,
          overflow: applySoftWrap
              ? TextOverflow.visible
              : TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: font,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            height: height,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = outlineWidth
              ..color = Colors.white,
          ),
        ),

        // Texto principal
        Text(
          text,
          textAlign: _textAlign,
          softWrap: applySoftWrap,
          overflow: applySoftWrap
              ? TextOverflow.visible
              : TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: font,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            height: height,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
