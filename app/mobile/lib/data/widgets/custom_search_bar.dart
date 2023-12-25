import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/constants/palette.dart';

class CustomSearchBarState extends State<CustomSearchBar> {
  bool focus = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      decoration: BoxDecoration(
        color: focus ? ThemePalette.light : ThemePalette.light.withOpacity(0.7),
        border: Border.all(
            color:
                focus ? ThemePalette.dark : ThemePalette.dark.withOpacity(0.4),
            width: 1.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          focus
              ? SvgPicture.asset(
                  Assets.search,
                  width: 12,
                  height: 12,
                )
              : SvgPicture.asset(
                  Assets.searchPassive,
                  width: 12,
                  height: 12,
                ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: widget.controller,
              textAlignVertical: TextAlignVertical.center,
              showCursor: focus ? true : false,
              onTap: () {
                setState(() {
                  focus = true;
                });
              },
              onTapOutside: (event) {
                setState(() {
                  focus = false;
                });
              },
              onChanged: widget.onChanged,
              style: TextStyle(
                color: focus
                    ? ThemePalette.dark
                    : ThemePalette.dark.withOpacity(0.4),
                fontSize: 12,
                fontWeight: FontWeight.w300,
                letterSpacing: -0.2,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

class CustomSearchBar extends StatefulWidget {
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  const CustomSearchBar({
    super.key,
    this.onChanged,
    this.controller,
  });

  @override
  State<CustomSearchBar> createState() => CustomSearchBarState();
}
