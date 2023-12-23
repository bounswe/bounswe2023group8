import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/widgets/custom_app_bar.dart';

import '../controllers/settings_controller.dart';

class PrivacyAndSafetyView extends GetView<SettingsController> {
  const PrivacyAndSafetyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        leadingAppIcon: true,
        leadingBackIcon: true,
        search: false,
        notification: false,
        actions: [],
      ),
      body: Column(
       
          children: [
            Container(
              width: Get.width,
                  decoration: const BoxDecoration(
                    color: Color(0xFF486375),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: const Text(
                    textAlign: TextAlign.center,
                    'Privacy and Setting',
                    style: TextStyle(
                      color: Color(0xFFF1F1F1),
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                      letterSpacing: -0.34,
                    ),
                  ),
                ),
                Container(
                    width: 360,
                    height: 497,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCDCFCF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Text(
                      '\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ac convallis risus. Etiam a nibh nibh. Ut gravida commodo bibendum. Suspendisse quis tristique est, vel mattis felis. Nulla facilisi. Sed consectetur tellus eu volutpat euismod. Nulla facilisi. Pellentesque porta dolor sed massa sollicitudin, ut consequat mauris pellentesque. Duis feugiat auctor nisl, sollicitudin eleifend purus maximus in. Nam blandit, lacus non hendrerit pharetra, urna felis feugiat enim, sed pulvinar diam ex eu nisl. Aliquam orci ex, varius sit amet purus vitae, imperdiet pretium orci. Duis ut nunc eu turpis finibus finibus. Praesent mi nisl, pharetra vel sapien et, euismod bibendum diam. Etiam vitae sapien consequat, dictum ipsum eu, consectetur velit. Nulla et nisl gravida, pellentesque sem id, semper lectus.\nPellentesque aliquam non diam at tempus. Etiam dictum odio eget condimentum molestie. Integer magna velit, aliquet at lacinia sit amet, tempor at nisi. Morbi a finibus urna. Nullam vitae diam lectus. In venenatis odio bibendum libero dignissim, mollis feugiat nisi feugiat. Phasellus tristique arcu vitae enim sodales posuere. Integer aliquet dolor magna, sit amet semper erat rutrum eu. Praesent ultricies diam risus, ut rutrum libero suscipit ac. Donec sodales dolor quis lacus gravida, et ultricies odio dignissim. Quisque volutpat semper eros ut convallis. Nullam id ex et quam bibendum tincidunt vitae at nisl. Pellentesque lacinia eros arcu, eu tincidunt justo posuere ut.',
                      style: TextStyle(
                        color: Color(0xFF434343),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                        letterSpacing: -0.20,
                      ),
                    ),),
              ],
            ),
          
        
      ),
    );
  }
}
