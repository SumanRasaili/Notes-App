import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.label,
      this.radius,
      this.width,
      this.height,
      this.fontSize,
      this.backgroundColor,
      this.labelColor,
      this.fontWeight,
      this.borderRadius,
      this.icon,
      this.leftIcon,
      this.isOutlined = false});
  final VoidCallback? onPressed;
  final String label;
  final double? radius;
  final double? width;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Widget? icon;
  final Widget? leftIcon;
  final Color? labelColor;
  final bool isOutlined;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 48,
      width: width ?? double.infinity,
      child: !isOutlined
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                backgroundColor:
                    backgroundColor ?? Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      borderRadius ?? BorderRadius.circular(radius ?? 10.0),
                ),
              ),
              onPressed: onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  leftIcon ?? const SizedBox.shrink(),
                  Text(
                    label,
                    style: TextStyle(
                      color: labelColor ?? Colors.white,
                      fontSize: fontSize ?? 16,
                      fontWeight: fontWeight ?? FontWeight.w500,
                    ),
                  ),
                  icon ?? const SizedBox.shrink(),
                ],
              ),
            )
          : OutlinedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                // backgroundColor: backgroundColor ?? AppColors.primaryColor,
                side: BorderSide(
                    color: backgroundColor ?? Theme.of(context).primaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      borderRadius ?? BorderRadius.circular(radius ?? 10.0),
                ),
              ),
              onPressed: onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  leftIcon ?? const SizedBox.shrink(),
                  Text(
                    label,
                    style: TextStyle(
                      color: labelColor ?? Colors.white,
                      fontSize: fontSize ?? 16,
                      fontWeight: fontWeight ?? FontWeight.w500,
                    ),
                  ),
                  icon ?? const SizedBox.shrink(),
                ],
              ),
            ),
    );
  }
}
