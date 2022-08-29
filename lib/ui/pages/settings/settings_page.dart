import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proweb_presentations_web/domain/firebase/app_firebase_collections.dart';
import 'package:proweb_presentations_web/ui/pages/home_page/home_page.dart';
import 'package:proweb_presentations_web/ui/pages/settings/settings_page_aside.dart';
import 'package:proweb_presentations_web/ui/pages/settings/settings_page_content.dart';
import 'package:proweb_presentations_web/ui/router/app_navigator.dart';
import 'package:proweb_presentations_web/ui/widgets/limited_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> _chekAuth() async {
      final prefs = await SharedPreferences.getInstance();

      return prefs.getBool('auth') ?? false;
    }

    return FutureBuilder<bool>(
      future: _chekAuth(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if (!snapshot.hasData || data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (!data) {
            return const HomePage();
          }
          return const _SettingsPageBody();
        }
      },
    );
  }
}

class _SettingsPageBody extends StatelessWidget {
  const _SettingsPageBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stream = FirebaseFirestore.instance
        .collection(CollectionsNames.directions)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.home,
              (route) => false,
            );
          },
        ),
        toolbarHeight: 63,
        title: const Text(
          'Настройки',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            height: 1.23,
            fontFamily: 'Inter',
            fontSize: 22,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return LimitedContainer(
            alignment: Alignment.topCenter,
            maxWidth: 1200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SettingsPageAside(),
                SizedBox(width: 16),
                SettingsPageContent(),
              ],
            ),
          );
        },
      ),
    );
  }
}
