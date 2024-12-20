import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeaderTitleApp extends StatelessWidget implements PreferredSizeWidget {
  const HeaderTitleApp({super.key, this.title = 'Title', this.onTap});
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: theme.colorScheme.primary,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                onTap?.call();
              },
              icon: SvgPicture.asset(
                'assets/icons/chevron_left.svg',
                // ignore: deprecated_member_use
                color: theme.colorScheme.tertiary,
              )),
          Text(
            title,
            style: TextStyle(color: theme.colorScheme.tertiary),
          ),
          const SizedBox(
            width: 50,
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
