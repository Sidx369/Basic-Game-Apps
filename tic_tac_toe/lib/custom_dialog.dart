import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final title;
  final content;
  final VoidCallback callBack;
  final actionText;

  CustomDialog(this.title, this.content, this.callBack,
      [this.actionText = 'reset']);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [FlatButton(onPressed: callBack, child: Text(actionText))],
    );
  }
}
