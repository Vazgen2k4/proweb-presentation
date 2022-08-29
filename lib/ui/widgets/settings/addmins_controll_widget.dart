import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proweb_presentations_web/domain/firebase/app_firebase_collections.dart';
import 'package:proweb_presentations_web/domain/providers/settings_provider.dart';
import 'package:proweb_presentations_web/ui/widgets/card_container.dart';
import 'package:proweb_presentations_web/ui/widgets/settings/field_controll_widget.dart';

class AdminsContorllWidget extends StatelessWidget {
  const AdminsContorllWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _stream = FirebaseFirestore.instance
        .collection(CollectionsNames.admins)
        .snapshots();

    return CardContainer(
      constraints: const BoxConstraints(maxHeight: 324),
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _stream,
        builder: (context, snapshot) {
          final data = snapshot.data;

          if (!snapshot.hasData || data == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final _adminsI = data.docs.map<Map<String, dynamic>>((e) => e.data());
          final _admins = _adminsI.toList();

          if (_admins.isEmpty) {
            return const Center(
              child: Text(
                'Редакторы не найдены',
                style: TextStyle(
                  color: Color(0xff323232),
                  fontSize: 16,
                  height: 1,
                  letterSpacing: .4,
                ),
              ),
            );
          }

          return Column(
            children: [
              const Text(
                'Редакторы',
                style: TextStyle(
                  color: Color(0xff323232),
                  fontSize: 16,
                  height: 1,
                  letterSpacing: .4,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: _admins.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final settingsModel = context.read<SettingsProvider>();

                    IconButton? btn = IconButton(
                      splashRadius: 20,
                      onPressed: () {
                        settingsModel.removeAdmin(_admins[index]['email']);
                      },
                      icon: const Icon(Icons.delete),
                      color: const Color.fromARGB(255, 0, 0, 0),
                    );

                    if (_admins[index]['primary']) btn = null;

                    return FieldControlWidget(
                      padding: const EdgeInsets.all(5),
                      title: Text(
                        '${_admins[index]['email']}',
                        style: const TextStyle(
                          color: Color(0xff323232),
                          fontSize: 16,
                          height: 1,
                          letterSpacing: .4,
                        ),
                      ),
                      trailing: btn,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
