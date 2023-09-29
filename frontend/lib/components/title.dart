import 'package:flutter/material.dart' hide Title;
import '../style.dart';


class Title extends StatelessWidget {
  final String title;

  const Title(
    this.title,
    {Key? key}
  ) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      margin: Style.tertiaryBottomMargin,
      alignment: Alignment.center,
      child: Text(
        title,
        style: const TextStyle(
          color: Style.primaryColor,
          fontSize: 24.0,
          fontWeight: FontWeight.w700
        )
      )
    );
  }
}
