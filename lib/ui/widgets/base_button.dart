import 'package:comida/shared/color.dart';
import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  @required final double width;
  @required final double height;
  @required final Widget child;
  @required final Function onPressed;
  final EdgeInsetsGeometry margin;
  final Color color;

  BaseButton({
    this.width,
    this.height,
    this.child,
    this.onPressed, 
    this.margin,
    this.color = accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: RaisedButton(
        elevation: 0,
        onPressed: onPressed,
        color: color,
        disabledColor: greyColor,
        child: child,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}