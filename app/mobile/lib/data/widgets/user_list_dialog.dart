import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/models/enigma_user.dart';
import 'package:mobile/routes/app_pages.dart';

class UserListDialogState extends State<UserListDialog> {
  late int selectedSection;

  @override
  void initState() {
    super.initState();
    selectedSection = widget.defaultSection;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: BackgroundPalette.soft,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 128),
      titlePadding:
          const EdgeInsets.only(left: 32, right: 16, top: 16, bottom: 16),
      contentPadding: const EdgeInsets.only(top: 0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.title,
              style: TextStyle(
                color: ThemePalette.dark,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.4,
              )),
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: SvgPicture.asset(
              Assets.cancel,
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
      children: [
        if (widget.sections.isNotEmpty)
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: widget.sections
                .map(
                  (section) => Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedSection = widget.sections.indexOf(section);
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                section == widget.sections[selectedSection]
                                    ? 8
                                    : 6),
                        decoration: BoxDecoration(
                          color: widget.sectionColors.isEmpty
                              ? SeparatorPalette.dark
                              : widget.sectionColors[
                                  widget.sections.indexOf(section)],
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                        ),
                        child: Text(
                          section,
                          style: TextStyle(
                            color: widget.sectionColors.isEmpty
                                ? SeparatorPalette.light
                                : widget.sectionTextColors[
                                    widget.sections.indexOf(section)],
                            fontSize: 12,
                            fontWeight:
                                section == widget.sections[selectedSection]
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                            letterSpacing: -0.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        const SizedBox(height: 8),
        SizedBox(
          width: Get.width - 64,
          height: Get.height - 356,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.users[selectedSection].length,
            itemBuilder: (context, index) {
              final user = widget.users[selectedSection][index];
              final isRemove = widget.isRemovable[selectedSection];
              return ListTile(
                onTap: () =>
                    Get.toNamed(Routes.profile, arguments: {'userId': user.id}),
                leading: Image.asset(
                  Assets.profilePlaceholder,
                  width: 40,
                  height: 40,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: TextStyle(
                        color: ThemePalette.dark,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.35,
                      ),
                    ),
                    Text(
                      '@${user.username}',
                      style: TextStyle(
                        color: ThemePalette.dark,
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        letterSpacing: -0.15,
                      ),
                    ),
                  ],
                ),
                trailing: isRemove
                    ? InkWell(
                        onTap: () => setState(() {
                          widget.onRemove?[selectedSection](user.id);
                          widget.users[selectedSection].remove(user);
                        }),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: BackgroundPalette.light,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            widget.removeTexts?[selectedSection] ?? 'Remove',
                            style: TextStyle(
                              color: ThemePalette.negative,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                      )
                    : null,
              );
            },
          ),
        ),
      ],
    );
  }
}

class UserListDialog extends StatefulWidget {
  final String title;
  final List<String> sections;
  final int defaultSection;
  final List<Color> sectionColors;
  final List<Color> sectionTextColors;
  final List<List<EnigmaUser>> users;
  final List<bool> isRemovable;
  final List<String>? removeTexts;
  final List<void Function(int)>? onRemove;
  const UserListDialog({
    super.key,
    required this.title,
    required this.sections,
    this.defaultSection = 0,
    this.sectionColors = const [],
    this.sectionTextColors = const [],
    required this.users,
    required this.isRemovable,
    this.removeTexts,
    this.onRemove,
  });

  @override
  State<UserListDialog> createState() => UserListDialogState();
}
