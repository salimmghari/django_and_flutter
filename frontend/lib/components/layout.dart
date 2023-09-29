import 'package:flutter/material.dart';
import '../style.dart';


class Layout extends StatelessWidget {
  final Widget child;
  final bool top;
  final bool right;
  final bool bottom;
  final bool left;

  const Layout(
    this.child, 
    {
      this.top = true,
      this.right = true,
      this.bottom = true,
      this.left = true,
      Key? key
    }
  ) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SafeArea(
            top: top,
            right: right,
            bottom: bottom,
            left: left,                  
            child: Container(
              padding: Style.secondaryPadding,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Style.secondaryColor
              ),
              child: child
            )
          )
        )
      )
    );
  }
}
