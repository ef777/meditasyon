import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.width,
    required this.height,
    this.onPressed,
    this.color,
  });
  final Color? color;
  final Widget title;
  final double width;
  final double height;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(),
                backgroundColor: color ?? Colors.amber),
            onPressed: onPressed,
            child: title));
  }
}
