import 'package:flutter/material.dart';

void back<T>(BuildContext context, [T? response]) =>
    Navigator.of(context).pop(response);

Future<void> loading(BuildContext context) => popup(context,
    content: Center(child: CircularProgressIndicator.adaptive()));

Future<T> popup<T>(BuildContext context,
        {String? title,
        List<PopupAction<T>> actions = const [],
        Widget? content,
        bool barrierDismissible = false}) async =>
    await showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: title == null ? null : Text(title),
        content: content,
        actions: actions
            .map((e) => TextButton(
                  onPressed: () => back(context, e.value),
                  child: Text(e.text),
                ))
            .toList(),
      ),
    );

class PopupAction<T> {
  final String text;
  final T? value;
  PopupAction(this.text, [this.value]);
}
