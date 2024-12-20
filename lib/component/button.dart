import 'package:flutter/material.dart';

import '../config/app_size.dart';

class Button extends StatelessWidget {
  const Button(
      {super.key,
      this.text = '',
      this.borderRadius = 8,
      this.colorBt = Colors.blue,
      this.colorText = Colors.black,
      this.height = 45,
      this.width = 200,
      required this.onTap});
  final String text;
  final Color colorBt;
  final Color colorText;
  final double borderRadius;
  final double width;
  final double height;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap.call();
      },
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Text(
          text,
          style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: AppSize.size20,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
