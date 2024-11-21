import 'package:flutter/material.dart';
import '../style.dart';


class Button extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final IconData? icon;
  final Color color;
  final bool margin;
  final String? buttonKey;

  const Button(
    this.onTap, 
    {
      required this.title,
      this.icon,
      this.color = Style.primaryColor,
      this.margin = false,
      this.buttonKey,
      Key? key
    }
  ) : super(key: key);

  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        key: buttonKey == null ? null : Key(buttonKey.toString()),
        onTap: onTap,
        child: Container(
          padding: Style.primaryPadding,
          margin: margin ? Style.primaryBottomMargin : null,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Style.primaryRadius)
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Style.secondaryColor,
                size: 15.0
              ),
              SizedBox(
                width: icon != null ? 10.0 : 0.0
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Style.secondaryColor,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700
                )
              )
            ]
          ) 
        )
      )
    );
  }
}
