import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


bool _isPopupShowing = false;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void handleGlobalError(BuildContext context, dynamic error) {
  if (!_isPopupShowing) {
    _isPopupShowing = true;
    Map<String, dynamic> errorMap = getErrorMessage(error);

    if (error is TokenExpiredException) {
      print('Showing relogin dialog');
      showReloginDialog(context);
    } else if (error is DioException) {
      showErrorDialog(context, errorMap);
    } else {
      showGeneralErrorDialog(context, error);
    }

    Future.delayed(const Duration(seconds: 1), () {
      _isPopupShowing = false;
    });
  }
}

class TokenExpiredException implements Exception {
  final String? message;

  TokenExpiredException({this.message});

  @override
  String toString() => message ?? 'Token expired';
}

class BadRequestException implements Exception {
  final String message;

  BadRequestException(this.message);

  @override
  String toString() => message;
}

void showErrorDialog(BuildContext context, Map<String, dynamic> errorMap) {
  _showPopup(
    context,
    CustomAlertDialog(
      title: errorMap["title"],
      message: errorMap["message"],
      icon: Icons.error_outline,
    ),
  );
}

void showGeneralErrorDialog(BuildContext context, dynamic error) {
  _showPopup(
    context,
    CustomAlertDialog(
      title: 'Error',
      message: error.toString(),
      icon: Icons.warning_amber_rounded,
    ),
  );
}

void showReloginDialog(BuildContext context) {
  _showPopup(
    context,
    CustomAlertDialog(
      title: 'Session Expired',
      message: 'Your session has expired. Please log in again.',
      icon: Icons.login,
      actions: [
        TextButton(
          child: Text('Relogin', style: Theme.of(context).textTheme.bodyMedium),
          onPressed: () {
            Navigator.of(context,rootNavigator: true).pop();
            context.goNamed("login");
          },
        ),
        TextButton(
          child: Text('Cancel', style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ],
    ),
  );
}

void _showPopup(BuildContext context, Widget dialog) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext dialogContext) => dialog,
  ).then((_) {
    print("Dialog dismissed, setting isPopupShowing to false");
    _isPopupShowing = false;
  });
}

Map<String, String> getErrorMessage(dynamic error) {
  String title;
  String message;

  if (error is TokenExpiredException) {
    title = 'Session Expired';
    message = 'Your session has expired. Please log in again.';
  } else if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionError:
        title = 'Connection Error';
        message = 'Failed to connect to the server. Please check your internet connection and try again.';
        break;
      case DioExceptionType.connectionTimeout:
        title = 'Connection Timeout';
        message = 'The connection timed out. Please try again later.';
        break;
      case DioExceptionType.receiveTimeout:
        title = 'Timeout';
        message = 'The server took too long to respond. Please try again later.';
        break;
      case DioExceptionType.badResponse:
        title = 'Bad Response';
        message = 'The server returned an unexpected response. Please try again later.';
        break;
      default:
        title = 'Error';
        message = 'An unexpected error occurred. Please try again.';
        break;
    }
  } else {
    title = 'Error';
    message = 'An unexpected error occurred. Please try again.';
  }

  return {'title': title, 'message': message};
}

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final List<Widget>? actions;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 200),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.5 + (0.5 * value),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: colorScheme.primary.withOpacity(0.1),
            width: 1.5,
          ),
        ),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colorScheme.primary.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: colorScheme.primary,
                    letterSpacing: 0.3,
                    height: 1.2,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: colorScheme.primary,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
        content: Text(
          message,
          style: TextStyle(
            color: colorScheme.onSurface.withOpacity(0.9),
            height: 1.5,
            letterSpacing: 0.2,
          ),
        ),
        actions: actions ??
            [
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: colorScheme.primary,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
        backgroundColor: colorScheme.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}