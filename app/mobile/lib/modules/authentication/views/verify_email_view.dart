import 'package:flutter/material.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/widgets/custom_app_bar.dart';

class SentEmailView extends StatelessWidget {
  final bool verify;
  const SentEmailView({
    super.key,
    required this.verify,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemePalette.white,
      appBar: CustomAppBar(
        search: false,
        notification: false,
        actions: [],
        leadingBackIcon: true,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.email,
                size: 100.0,
                color: Colors.blue, // Change the email icon color
              ),
              const SizedBox(height: 20.0),
              const Text(
                'We have sent an email to your email address.',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),
              Text(
                verify
                    ? 'Please verify your email address to continue.'
                    : 'Please click the link in the email to reset your password.',
                style: const TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}
