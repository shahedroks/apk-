import 'package:flutter/material.dart';

/// User feedback for actions that are UI-only in the mock/demo app.
void showMockSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    ),
  );
}
