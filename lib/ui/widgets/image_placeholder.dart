import 'package:comida/shared/color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImagePlaceholder extends StatelessWidget {
  final double width;
  final double height;
  final double size;

  ImagePlaceholder({
    @required this.width,
    @required this.height,
    @required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: greyColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          Icons.image,
          size: size,
        ),
      ),
    );
  }
}