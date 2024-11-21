import 'package:flutter/material.dart';
import '../style.dart';


class Field extends StatelessWidget {
  final void Function(String)? onChanged;
  final String label;
  final bool secure;
  final int? maxLines;
  final String? value;
  final String? fieldKey;

  const Field(
    this.onChanged,
    {
      required this.label,
      this.secure = false,
      this.maxLines = 1,
      this.value,
      this.fieldKey,
      Key? key
    }
  ) : super(key: key);

  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    controller.text = value == null ? '' : value.toString();

    return Container(
      margin: Style.primaryBottomMargin,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: Style.secondaryBottomMargin,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w700,
                color: Style.primaryColor
              )
            ),
          ),
          TextFormField(
            key: fieldKey == null ? null : Key(fieldKey.toString()),
            controller: value == null ? null : controller,
            maxLines: maxLines,
            obscureText: secure,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Style.primaryRadius),
                borderSide: BorderSide(
                  color: Style.primaryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Style.primaryRadius),
                borderSide: BorderSide(
                  color: Style.primaryColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Style.primaryRadius),
                borderSide: BorderSide(
                  color: Style.primaryColor,
                  width: 2.0, // You can adjust the width for focus
                ),
              ),
            ),
            style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              color: Style.primaryColor
            ),
            onChanged: onChanged
          )
        ]
      )
    );
  }
}
