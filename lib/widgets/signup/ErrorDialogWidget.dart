import 'package:flutter/material.dart';

class ErrorDialogWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorDialogWidget({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Error"),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("OK"),
        ),
        TextButton(
          onPressed: onRetry,
          child: Text("Retry"),
        ),
      ],
    );
  }
}
