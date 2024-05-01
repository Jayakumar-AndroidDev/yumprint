import 'package:flutter/material.dart';

class TextComponent extends StatelessWidget{

  const TextComponent(
    {
      super.key,
      required this.text,
      required this.textSize,
      required this.textColor,
      this.fontWeight = FontWeight.normal,
      this.textAlign = Alignment.centerLeft,
    }
  );

  final String text;
  final double textSize;
  final Color textColor;
  final FontWeight fontWeight;
  final Alignment textAlign;

  @override
  Widget build(BuildContext context) {
    return 
    Align(
      alignment: textAlign,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor,
          fontSize: textSize,
          fontWeight: fontWeight,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}