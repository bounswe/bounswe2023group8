import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile/data/widgets/custom_app_bar.dart';
import 'package:mobile/modules/settings/views/privacy_view.dart';
import 'package:mobile/routes/app_pages.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        leadingAppIcon: true,
        title: 'Settings',
        
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Container(
              width: 328,
              height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF486375),
              borderRadius: BorderRadius.circular(8),),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: const Text(
                'Account',
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

                width: 328,
                height: 260,
                padding: const EdgeInsets.only(
                top: 16,
                left: 32,
                right: 16,
                bottom: 16,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffCDCFCF),
                  borderRadius: BorderRadius.circular(8),
                ),

                  child: Column(
                    children: [
                      const Text(
                        'E-mail',
                        style: TextStyle(
                        color: Color(0xFF434343),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                        letterSpacing: -0.24,
                        ),
                        ),
                      Container(
                        width: 280,
                        height: 20,
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                        decoration: ShapeDecoration(
                          color: const Color(0xffFFFAF6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          ),
                          child: const Text(
                            'email',
                            style: TextStyle(
                                color: Color(0xFF434343),
                                fontSize: 10,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                height: 0,
                                letterSpacing: -0.17,
                            ),
                          )
                        ),
                    const SizedBox(height: 8), 
                        const Text(
                        'Username',
                        style: TextStyle(
                        color: Color(0xFF434343),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                        letterSpacing: -0.24,
                        ),
                        ),
                      Container(
                        width: 280,
                        height: 20,
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                        decoration: ShapeDecoration(
                          color: const Color(0xffFFFAF6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          ),
                          child: const Text(
                            'username',
                            style: TextStyle(
                                color: Color(0xFF434343),
                                fontSize: 10,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                height: 0,
                                letterSpacing: -0.17,
                            ),
                          )
                        ),
                    const SizedBox(height: 8), 
                        const Text(
                        'Password',
                        style: TextStyle(
                        color: Color(0xFF434343),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                        letterSpacing: -0.24,
                        ),
                        ),
                      Container(
                        width: 280,
                        height: 20,
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                        decoration: ShapeDecoration(
                          color: const Color(0xffFFFAF6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          ),
                        child: const Text(
                            '******',
                            style: TextStyle(
                                color: Color(0xFF434343),
                                fontSize: 10,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                height: 0,
                                letterSpacing: -0.17,
                            ),
                          )
                        ),
                        const SizedBox(height: 8), 
                        const Text(
                        'Birthday',
                        style: TextStyle(
                        color: Color(0xFF434343),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                        letterSpacing: -0.24,
                        ),
                        ),
                      Container(
                        width: 280,
                        height: 20,
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                        decoration: ShapeDecoration(
                          color: const Color(0xffFFFAF6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          ),
                          child: const Text(
                            'dd/mm/yyyy',
                            style: TextStyle(
                                color: Color(0xFF434343),
                                fontSize: 10,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                height: 0,
                                letterSpacing: -0.17,
                            ),
                          )
                        ),
                    const SizedBox(height: 12), 
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
                            width: 124,
                            height: 24,
                            decoration: ShapeDecoration(
                        color: const Color(0xFFC32626),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                ),
                            ),
                            child: const Text(
                              'Delete Account',
                              style: TextStyle(
                                  color: Color(0xFFF1F1F1),
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                  letterSpacing: -0.24,
                              ),
                          ),
                        ),
                      ],
                  ),
              ),


              const SizedBox(height: 16), 
              
              InkWell(
                onTap: () {
                  Get.to(() => const PrivacyAndSafetyView());
                },
                child: Container(
                  width: 328,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF486375),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: const Text(
                    'Privacy And Safety',
                    style: TextStyle(
                      color: Color(0xFFF1F1F1),
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.34,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () {
                  Get.offAllNamed(Routes.opening);
                },
                child:
                Container(
                width: 328,
                height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF486375),
                borderRadius: BorderRadius.circular(8),),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: const Text(
                  'Logout',
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
              ),
            ],
          ),
        ),
      ),
    );
  }

}
