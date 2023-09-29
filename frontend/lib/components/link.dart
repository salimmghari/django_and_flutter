import 'package:flutter/material.dart';
import '../style.dart';


class Link extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final bool margin;
  final String? linkKey;

  const Link(
    this.onTap, 
    {
      required this.title,
      this.margin = false,
      this.linkKey,
      Key? key
    }
  ) : super(key: key);

  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        key: linkKey == null ? null : Key(linkKey.toString()),
        onTap: onTap,
        child: Container(
          margin: margin ? Style.primaryBottomMargin : null,
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(
              color: Style.infoColor,
              fontSize: 12.0,
              fontWeight: FontWeight.w300
            )
          ) 
        )
      )
    );
  }
}
