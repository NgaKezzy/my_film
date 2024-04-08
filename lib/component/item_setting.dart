import 'package:flutter/material.dart';

class ItemSetting extends StatelessWidget {
  const ItemSetting({super.key, this.text = '', required this.onTap});
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        onTap.call();
      },
      child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(10),
          height: 60,
          width: width,
          child: Text(text)),
    );
  }
}
