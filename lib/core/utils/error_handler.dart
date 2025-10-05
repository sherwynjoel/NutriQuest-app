import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ErrorHandler {
  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  static void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static String getErrorMessage(error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return 'No user found with this email address.';
        case 'wrong-password':
          return 'Incorrect password.';
        case 'email-already-in-use':
          return 'An account already exists with this email.';
        case 'weak-password':
          return 'Password is too weak.';
        case 'invalid-email':
          return 'Invalid email address.';
        case 'user-disabled':
          return 'This account has been disabled.';
        case 'too-many-requests':
          return 'Too many attempts. Please try again later.';
        case 'operation-not-allowed':
          return 'This sign-in method is not enabled.';
        default:
          return 'Authentication error: ${error.message}';
      }
    }
    
    if (error is Exception) {
      return error.toString();
    }
    
    return 'An unexpected error occurred. Please try again.';
  }

  static void handleError(BuildContext context, error, {String? customMessage}) {
    final message = customMessage ?? getErrorMessage(error);
    showErrorSnackBar(context, message);
  }

  static Future<void> showErrorDialog(
    BuildContext context, {
    required String title,
    required String message,
    String? buttonText,
    VoidCallback? onPressed,
  }) async => showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(buttonText ?? 'OK'),
              onPressed: () {
                Navigator.of(context).pop();
                onPressed?.call();
              },
            ),
          ],
        ),
    );

  static Future<bool?> showConfirmDialog(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Yes',
    String cancelText = 'No',
  }) async => showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(cancelText),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text(confirmText),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
    );
}
