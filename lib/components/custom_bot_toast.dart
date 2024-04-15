import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class CustomBotToast {
  static text(
    String text, {
    required bool isSuccess,
    double opacity = 1,
  }) {
    return BotToast.showText(
      text: text,
      align: isSuccess ? const Alignment(0.0, 0.80) : Alignment.center,
      contentColor: isSuccess
          ? Colors.green.withOpacity(opacity)
          : Colors.red.withOpacity(opacity),
    );
  }

  static loading({
    String? text,
    Color? loaderColor,
  }) {
    return BotToast.showCustomLoading(
      toastBuilder: ((f) {
        return SizedBox(
          height: 90,
          child: Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 23,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 4.0,
                    color: loaderColor ?? Colors.green,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Text(
                    text ?? "Loading...",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}