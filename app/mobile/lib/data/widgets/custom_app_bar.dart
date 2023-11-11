import 'package:flutter/material.dart';

import '../constants/assets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool leadingAppIcon;
  final bool leadingBackIcon;
  final List<Widget>? actions;
  final String? title;
  final Widget? titleWidget;
  const CustomAppBar({
    super.key,
    this.leadingAppIcon = false,
    this.leadingBackIcon = false,
    this.title,
    this.titleWidget,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.3,
      leading: Padding(
        padding: const EdgeInsets.all(10.0),
        child: leadingAppIcon
            ? Image.asset(
                Assets.logo,
                height: 30,
                fit: BoxFit.contain,
              )
            : leadingBackIcon
                ? IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                : null,
      ),
      title: titleWidget ??
          Text(
            title ?? '',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
      backgroundColor: Colors.white,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
