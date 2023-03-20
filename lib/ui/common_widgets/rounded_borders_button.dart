import 'package:absher_rider/helpers/public_methods.dart';
import 'package:flutter/material.dart';

import '../../helpers/constants.dart';

class RoundBordersButton extends StatelessWidget {
  final String title;
  final double fontSize;
  final bool selected;
  final double verticalPadding;
  final double radius;

  final onPressed;

  const RoundBordersButton(
      {Key? key, required this.title, required this.onPressed, this.fontSize = 18, this.selected = false, this.verticalPadding = 8, this.radius = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          // width: 170,

          padding: EdgeInsets.symmetric(horizontal: 20, vertical: verticalPadding),
          child: Center(
              child: Text(
                "${title}",
                style: TextStyle(
                    fontSize: fontSize, fontWeight: FontWeight.w500, color: selected ? Colors.white: mainColorLight),
              )),
          decoration: BoxDecoration(
            color: selected ? lightModeOn(context) ? mainColorLight : mainColorLight : lightModeOn(context) ? Colors.white : Colors.black12,
              border: Border.all(color:  mainColorLight, width: 1),
              borderRadius: BorderRadius.circular(radius)),
        ),
      ),
    );
  }
}
