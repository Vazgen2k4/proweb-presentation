import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proweb_presentations_web/domain/firebase/app_firebase_collections.dart';
import 'package:proweb_presentations_web/domain/providers/directions_provider.dart';

import 'home_page_app_bar.dart';
import 'home_page_body.dart';

// const directions = <String>[
//   'ВЕБ ПРОГРАММИРОВАНИЕ',
//   'ИНТЕРЕНЕТ МАРКЕТИНГ',
//   '3DS MAX & AUTOCAD',
// ];

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stream = FirebaseFirestore.instance
        .collection(CollectionsNames.directions)
        .snapshots();

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: stream,
      builder: (context, snapshot) {
        final model = context.read<DirectionsProvider>();
        model.setUp(snapshot.data);

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return DefaultTabController(
          length: model.lables.length,
          child: Scaffold(
            appBar: HomeAppBar(height: 112, key: UniqueKey()),
            body: HomePageBody(key: UniqueKey()),
          ),
        );
      },
    );
  }
}
