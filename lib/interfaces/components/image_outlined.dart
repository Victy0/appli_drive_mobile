import 'package:flutter/material.dart';

class ImageOutlined extends StatelessWidget {
  final String asset;
  final double size;
  final double outlineSize;

  const ImageOutlined({
    super.key,
    required this.asset,
    this.size = 60,
    this.outlineSize = 2,
  });

  @override
  Widget build(BuildContext context) {
    final offsets = [
      Offset(-outlineSize, -outlineSize),
      Offset(0, -outlineSize),
      Offset(outlineSize, -outlineSize),
      Offset(-outlineSize, 0),
      Offset(outlineSize, 0),
      Offset(-outlineSize, outlineSize),
      Offset(0, outlineSize),
      Offset(outlineSize, outlineSize),
    ];

    return SizedBox(
      width: size + outlineSize * 2,
      height: size + outlineSize * 2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          for (final offset in offsets)
            Transform.translate(
              offset: offset,
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
                child: Image.asset(
                  asset,
                  width: size,
                  height: size,
                ),
              ),
            ),

          Image.asset(
            asset,
            width: size,
            height: size,
          ),
        ],
      ),
    );
  }
}