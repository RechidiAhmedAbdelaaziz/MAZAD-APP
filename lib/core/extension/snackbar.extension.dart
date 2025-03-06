import 'package:flutter/material.dart';
import 'package:mazad_app/core/shared/classes/dimensions.dart';

extension SnackbarExtension on BuildContext {
  void _showSnackbar(
    String message,
    Color color,
    Color textColor,
    IconData icon,
  ) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: textColor),
            widthSpace(10),
            Expanded(
              child: Text(
                message,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showSuccessSnackbar(String message) => _showSnackbar(
    message,
    Colors.green,
    Colors.white,
    Icons.check_circle,
  );

  void showErrorSnackbar(String message) =>
      _showSnackbar(message, Colors.red, Colors.white, Icons.error);

  void showInfoSnackbar(String message) =>
      _showSnackbar(message, Colors.blue, Colors.white, Icons.info);

  void showWarningSnackbar(String message) => _showSnackbar(
    message,
    Colors.orange,
    Colors.white,
    Icons.warning,
  );
}
