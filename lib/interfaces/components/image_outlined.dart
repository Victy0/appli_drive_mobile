import 'package:flutter/material.dart';
import 'dart:math';

class ImageOutlined extends StatelessWidget {
  final String asset;
  final double size;
  final double outlineSize;
  final Color outlineColor;

  const ImageOutlined({
    super.key,
    required this.asset,
    this.size = 60,
    this.outlineSize = 2,
    this.outlineColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    // Mais posições para evitar falhas no contorno.
    const points = 32;

    final offsets = List.generate(points, (i) {
      final angle = (2 * pi * i) / points;

      return Offset(
        outlineSize * cos(angle),
        outlineSize * sin(angle),
      );
    });

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
                colorFilter: ColorFilter.mode(
                  outlineColor,
                  BlendMode.srcIn,
                ),
                child: Image.asset(
                  asset,
                  width: size,
                  height: size,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),

          Image.asset(
            asset,
            width: size,
            height: size,
            filterQuality: FilterQuality.high,
          ),
        ],
      ),
    );
  }
}