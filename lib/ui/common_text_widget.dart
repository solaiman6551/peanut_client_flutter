import 'package:flutter/material.dart';


class CommonTextWidget extends StatelessWidget {

  final String text;
  final TextStyle style;
  final TextAlign? textAlign;
  final bool shouldShowMultipleLine;
  final int? maxLines;
  final bool? softWrap;

  const CommonTextWidget({
        super.key,
        required this.text,
        required this.style,
        this.textAlign = TextAlign.left,
        this.shouldShowMultipleLine = true,
        this.maxLines = 1,
        this.softWrap
  });

  @override
  Widget build(BuildContext context) {
    if (shouldShowMultipleLine == false) {
      return FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            style: style,
            textAlign: textAlign,
          ));
    }
    else {
      return Text(
          text,
          style: style,
          textAlign: textAlign
      );
    }
  }

}
