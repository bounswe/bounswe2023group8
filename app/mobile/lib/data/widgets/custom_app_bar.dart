import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/widgets/custom_search_bar.dart';

import '../constants/assets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool leadingAppIcon;
  final bool leadingBackIcon;
  final List<Widget> actions;
  final bool search;
  final Function(String)? onSearchQueryChanged;
  final bool notification;
  const CustomAppBar({
    super.key,
    this.leadingAppIcon = false,
    this.leadingBackIcon = false,
    required this.search,
    this.onSearchQueryChanged,
    required this.notification,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ThemePalette.white,
      titleSpacing: 32,
      elevation: 0.5,
      shadowColor: SeparatorPalette.dark,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
        child: Row(
          children: [
            if (leadingBackIcon) ...[
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
            if (leadingAppIcon) ...[
              Image.asset(
                Assets.logo,
                width: 35,
                height: 40,
              )
            ],
          ],
        ),
      ),
      title: search
          ? CustomSearchBar(
              onChanged: onSearchQueryChanged,
            )
          : null,
      actions: notification
          ? actions +
              [
                SvgPicture.asset(
                  Assets.notification,
                  width: 18,
                  height: 20,
                ),
                const SizedBox(width: 16),
              ]
          : actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
