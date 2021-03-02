import 'package:comida/shared/color.dart';
import 'package:comida/shared/font.dart';
import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double voteAverage;
  final double starSize;
  final double fontSize;
  final Color color;
  final MainAxisAlignment mainAxisAlignment;

  RatingStars({
    this.voteAverage = 0,
    this.starSize = 20,
    this.fontSize = 12,
    this.color,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    int n = voteAverage.floor();

    List<Widget> widgets = List.generate(5, (index) => Icon(
      index < n ? Icons.star : Icons.star_border,
      color: yellowColor,
      size: starSize,
    ));

    widgets.add(
      SizedBox(width: 3)
    );

    widgets.add(
      Text(
        "$voteAverage",
        style: lightBaseFont.copyWith(
          fontSize: fontSize,
          color: color,
        ),
      ),
    );

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: widgets,
    );
  }
}