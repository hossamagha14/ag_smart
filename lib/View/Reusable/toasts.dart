import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

errorToast(context, String errorMessage) {
  showToast(errorMessage,
      backgroundColor: Colors.red,
      context: context,
      animation: StyledToastAnimation.scale,
      position: StyledToastPosition.bottom,
      animDuration: const Duration(seconds: 0),
      duration: const Duration(seconds: 3));
}

expiredTokenToast(context) {
  showToast('Access token has expired please log in again',
      backgroundColor: Colors.red,
      context: context,
      animation: StyledToastAnimation.scale,
      position: StyledToastPosition.bottom,
      animDuration: const Duration(seconds: 0),
      duration: const Duration(seconds: 5));
}

serverDownToast(context) {
  showToast('Server is down please try again later',
      backgroundColor: Colors.red,
      context: context,
      animDuration: const Duration(seconds: 0),
      animation: StyledToastAnimation.scale,
      position: StyledToastPosition.bottom,
      duration: const Duration(seconds: 5));
}

successToast(context, String successMessage) {
  showToast(successMessage,
      backgroundColor: Colors.green,
      context: context,
      animation: StyledToastAnimation.scale,
      animDuration: const Duration(seconds: 0),
      position: StyledToastPosition.bottom,
      duration: const Duration(seconds: 3));
}
