import 'package:flutter/material.dart';

AppBar Appbar_Default(String title, BuildContext context) {
  return AppBar(
    title: Text(title),
    leading: IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(Icons.arrow_back_rounded),
    ),
  );
}
