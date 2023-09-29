import 'package:flutter/material.dart';
import '../components/button.dart';
import '../components/field.dart';
import '../style.dart';


class Note extends StatelessWidget {
  final String title;
  final String body;
  final void Function(String)? onTitleChanged;
  final void Function(String)? onBodyChanged;
  final void Function()? onCreate;
  final void Function()? onUpdate;
  final void Function()? onDelete;
  final bool last;
  final String? titleFieldKey;
  final String? bodyFieldKey;
  final String? createButtonKey;
  final String? updateButtonKey;
  final String? deleteButtonKey;

  const Note(
    {
      this.title = '',
      this.body = '',
      required this.onTitleChanged,
      required this.onBodyChanged,
      this.onCreate,
      this.onUpdate,
      this.onDelete,
      this.last = false,
      this.titleFieldKey,
      this.bodyFieldKey,
      this.createButtonKey,
      this.updateButtonKey,
      this.deleteButtonKey,
      Key? key
    }
  ) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      padding: Style.secondaryPadding,
      margin: last ? null : Style.tertiaryBottomMargin,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Style.primaryRadius),
        color: Style.secondaryColor,
        border: Border.all(
          color: Style.primaryColor
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Field(
            onTitleChanged,
            label: 'Title:',
            value: title,
            fieldKey: titleFieldKey
          ),
          Field(
            onBodyChanged,
            label: 'Body:',
            value: body,
            maxLines: 10,
            fieldKey: bodyFieldKey
          ),
          onCreate != null ? Button(
            onCreate,
            title: 'Create',
            icon: Icons.add,
            color: Style.successColor,
            buttonKey: createButtonKey
          ) : Container(),
          onUpdate != null ? Button(
            onUpdate,
            title: 'Update',
            icon: Icons.edit,
            color: Style.warningColor,
            margin: true,
            buttonKey: updateButtonKey
          ) : Container(),
          onDelete != null ? Button(
            onDelete,
            title: 'Delete',
            icon: Icons.delete,
            color: Style.dangerColor,
            buttonKey: deleteButtonKey
          ) : Container()
        ]
      )
    );
  }
}
