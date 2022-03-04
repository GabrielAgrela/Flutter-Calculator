import 'package:flutter/material.dart';

// creating Stateless Widget for buttons
class DigitButton extends StatelessWidget 
{

  // declaring variables
  final color;
  final textColor;
  final String buttonText;
  final buttontapped;

  //Constructor
  DigitButton({this.color, this.textColor, required this.buttonText, this.buttontapped});

  @override
  Widget build(BuildContext context) 
  {
    return GestureDetector
    (
      onTap: buttontapped,
      child: Padding
      (
        padding: const EdgeInsets.all(5),
        child: ClipRRect
        (
          borderRadius: BorderRadius.circular(35),
          child: Container
          (
            color: color,
            child: Center
            (
              child: Text
              (
                buttonText,
                style: TextStyle
                (
                  color: textColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


