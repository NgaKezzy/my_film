import 'package:flutter/material.dart';

class HeaderApp extends StatelessWidget implements PreferredSizeWidget {
  const HeaderApp({super.key, this.title = 'Title'});
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: theme.colorScheme.primary,
      automaticallyImplyLeading: false,
      title: Center(
          child: Text(
        title,
        style: TextStyle(color: theme.colorScheme.tertiary),
      )),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
