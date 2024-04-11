import 'package:flutter/material.dart';

import '../config/app_size.dart';

class FlagAndCountryName extends StatelessWidget {
  const FlagAndCountryName(
      {super.key,
      this.width = 70,
      this.height = 70,
      this.countryName = 'English',
      this.pathImage = '',
      this.isSelected = false,
      required this.onTap});
  final double width, height;
  final String countryName, pathImage;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        onTap.call();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            color:
                isSelected ? theme.colorScheme.onSecondary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                style: BorderStyle.solid, color: theme.colorScheme.tertiary)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset('assets/images/$pathImage')),
            Text(
              countryName,
              style: const TextStyle(
                  fontSize: AppSize.size20, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
