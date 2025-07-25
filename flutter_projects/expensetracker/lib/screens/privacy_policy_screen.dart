import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Privacy Policy"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Privacy Policy",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Last updated: March 19, 2025\n\n"
                "Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your personal information when you use our Finance App.\n\n"
                "1. Information We Collect\n"
                "We may collect the following information:\n"
                "- Personal Information: Name, email address, and profile image.\n"
                "- Transaction Data: Details of your financial transactions, such as income and expenses.\n"
                "- Usage Data: Information about how you use the app, such as app interactions and preferences.\n\n"
                "2. How We Use Your Information\n"
                "We use your information to:\n"
                "- Provide and improve our services.\n"
                "- Personalize your experience, such as displaying your name and profile image.\n"
                "- Analyze app usage to enhance functionality and user experience.\n\n"
                "3. Data Security\n"
                "We implement reasonable security measures to protect your data, including encryption and secure storage. However, no method of transmission over the internet is 100% secure.\n\n"
                "4. Sharing Your Information\n"
                "We do not share your personal information with third parties except:\n"
                "- With your consent.\n"
                "- To comply with legal obligations.\n"
                "- To protect the rights and safety of our users and the public.\n\n"
                "5. Your Rights\n"
                "You have the right to:\n"
                "- Access and update your personal information.\n"
                "- Request deletion of your data.\n"
                "- Opt-out of certain data collection practices.\n\n"
                "6. Contact Us\n"
                "If you have any questions about this Privacy Policy, please contact us at:\n"
                "Email: support@financeapp.com\n\n"
                "By using our app, you agree to the terms of this Privacy Policy.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
