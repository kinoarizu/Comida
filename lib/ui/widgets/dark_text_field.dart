import 'package:comida/shared/color.dart';
import 'package:comida/shared/font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DarkTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final Function onChanged;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final String errorValidation;
  final int maxLines;
  final TextInputFormatter inputFormatter;

  DarkTextField({
    this.labelText,
    this.hintText,
    this.controller,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.prefixIcon,
    this.errorValidation,
    this.maxLines,
    this.inputFormatter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (labelText != null) Text(
              labelText,
              style: regularBaseFont.copyWith(fontSize: 12),
            ),
            if (errorValidation != null) Text(
              errorValidation,
              style: regularBaseFont.copyWith(
                color: redColor,
                fontSize: 11,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 4,
        ),
        TextField(
          obscureText: obscureText,
          controller: controller,
          keyboardType: keyboardType,
          style: regularBaseFont.copyWith(fontSize: 14),
          maxLines: (maxLines != null) ? maxLines : 1,
          onChanged: onChanged,
          inputFormatters: (inputFormatter != null) ? [inputFormatter] : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: baseColor,
            hintText: hintText,
            hintStyle: regularBaseFont.copyWith(
              fontSize: 14,
              color: Color(0xFFBEBEBE),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: borderColor,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: whiteColor,
                width: 1.5,
              ),
            ),
            suffixIcon: suffixIcon,
            prefix: prefixIcon,
          ),
        ),
      ],
    );
  }
}