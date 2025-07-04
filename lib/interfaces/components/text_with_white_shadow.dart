import 'package:flutter/material.dart';

class TextWithWhiteShadow extends StatefulWidget {
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
  TextWithWhiteShadowState createState() => TextWithWhiteShadowState();
}

class TextWithWhiteShadowState extends State<TextWithWhiteShadow> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      textAlign: widget.align == "right"
        ? TextAlign.right
        : widget.align == "left"
          ? TextAlign.left
          : widget.align == "center"
            ? TextAlign.center
            : null,
      softWrap: widget.applySoftWrap,
      overflow: widget.applySoftWrap ? TextOverflow.visible : TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: widget.fontFamily ? Icons.arrow_upward.fontFamily : null,
        fontSize: widget.fontSize,
        fontWeight: FontWeight.bold,
        height: widget.height,
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
