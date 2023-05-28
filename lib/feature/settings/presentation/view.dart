// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:neopop/neopop.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:scan_gpt/core/extensions/context_extensions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wiredash/wiredash.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const _SettingsBody(),
    );
  }
}

class _SettingsBody extends StatelessWidget {
  const _SettingsBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingAllDefault,
      child: Column(
        children: [
          const Image(
            image: AssetImage(
              'assets/icons/logo_circle.png',
            ),
            height: 100,
            width: 100,
          ),
          const SizedBox(height: 10),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  '${snapshot.data?.appName}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          const SizedBox(height: 10),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  'Version ${snapshot.data!.version}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          const SizedBox(height: 10),
          const Text(
            'ScanGPT is an open source project. '
            'If you have any feedback or suggestions, '
            'please send them to us.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text(
            'ScanGPT is not affiliated with OpenAI. '
            'OpenAI is a registered trademark of OpenAI, Inc.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: context.width,
            child: Center(
              child: NeoPopButton(
                onTapUp: () => _sendFeedback(context),
                color: const Color.fromARGB(255, 126, 49, 227),
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Send Feedback'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: context.width,
            child: Center(
              child: NeoPopButton(
                onTapUp: () => _openSourceLicenses(context),
                color: const Color.fromARGB(255, 33, 211, 84),
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Open Source Licenses'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: context.width,
            child: Center(
              child: NeoPopButton(
                onTapUp: () => launchUrl(
                  Uri(
                    scheme: 'https',
                    host: 'scangpt.space',
                  ),
                ),
                color: const Color.fromARGB(255, 248, 232, 50),
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Website'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: context.width,
            child: Center(
              child: NeoPopButton(
                onTapUp: () => launchUrl(
                  Uri(
                    scheme: 'https',
                    host: 'za16.co',
                  ),
                ),
                color: const Color.fromARGB(255, 255, 255, 255),
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Developer'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendFeedback(BuildContext context) {
    Wiredash.of(context).show(inheritMaterialTheme: true);
  }

  void _openSourceLicenses(BuildContext context) {
    showLicensePage(
      context: context,
      applicationName: 'Scan GPT',
      applicationVersion: '1.3.0',
      applicationIcon: const Image(
        image: AssetImage(
          'assets/icons/logo_circle.png',
        ),
        height: 100,
        width: 100,
      ),
    );
  }
}
