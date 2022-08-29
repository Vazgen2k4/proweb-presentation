import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proweb_presentations_web/domain/firebase/app_firebase_collections.dart';
import 'package:proweb_presentations_web/domain/providers/settings_provider.dart';
import 'package:proweb_presentations_web/ui/widgets/card_container.dart';
import 'package:proweb_presentations_web/ui/widgets/settings/field_controll_widget.dart';

class TeachersContorllWidget extends StatelessWidget {
  const TeachersContorllWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _stream = FirebaseFirestore.instance
        .collection(CollectionsNames.directions)
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

          final _teachersMatrix = data.docs.map<List>((e) => e['teachers']);

          if (_teachersMatrix.isEmpty) {
            return const Center(
              child: Text(
                'Учителя не найдены',
                style: TextStyle(
                  color: Color(0xff323232),
                  fontSize: 16,
                  height: 1,
                  letterSpacing: .4,
                ),
              ),
            );
          }

          final _teachers = _teachersMatrix.reduce((e, v) => e + v);

          if (_teachers.isEmpty) {
            return const Center(
              child: Text(
                'Учителя не найдены',
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
                'Учителя',
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
                  itemCount: _teachers.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return _TeachersContorllWidgetItem(
                      index: index,
                      teachers: _teachers,
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

class _TeachersContorllWidgetItem extends StatelessWidget {
  final List<dynamic> teachers;
  final int index;
  const _TeachersContorllWidgetItem({
    Key? key,
    required this.teachers,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<String> getUrl() async {
      return (await FirebaseStorage.instance
          .ref()
          .child(teachers[index]["img"])
          .getDownloadURL());
    }

    final settingsModel = context.read<SettingsProvider>();

    return FieldControlWidget(
      padding: const EdgeInsets.all(5),
      title: Row(
        children: [
          FutureBuilder<String>(
            future: getUrl(),
            builder: (context, snapshot) {
              final url = snapshot.data;
              if (!snapshot.hasData || url == null) {
                return const SizedBox(
                  width: 100,
                  height: 68,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return Container(
                margin: const EdgeInsets.only(top: 4, bottom: 2),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(url),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                width: 100,
                height: 62,
              );
            },
          ),
          const SizedBox(width: 10),
          Text(
            teachers[index]['name'].toString(),
            style: const TextStyle(
              color: Color(0xff323232),
              fontSize: 16,
              height: 1,
              letterSpacing: .4,
            ),
          ),
        ],
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: IconButton(
          splashRadius: 20,
          onPressed: () {
            settingsModel.teacher.removeTeacher(path: teachers[index]["img"]);
          },
          icon: const Icon(Icons.delete),
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }
}
