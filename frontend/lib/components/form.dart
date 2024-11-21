import 'package:flutter/material.dart';
import '../style.dart';


class Form extends StatelessWidget {
  final List<Widget> children;

  const Form(
    this.children,
    {Key? key}
  ) : super(key: key);
  
  Widget build(BuildContext context) {
    return Container(
      padding: Style.secondaryPadding,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Style.primaryRadius),
        color: Style.secondaryColor,
        border: Border.all(
          color: Style.primaryColor
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children
      )
    );
  }
}
