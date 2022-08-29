import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:proweb_presentations_web/domain/firebase/app_firebase_collections.dart';
import 'package:proweb_presentations_web/domain/providers/settings_provider.dart';
import 'package:proweb_presentations_web/ui/widgets/add_btn_widget.dart';
import 'package:proweb_presentations_web/ui/widgets/card_container.dart';
import 'package:proweb_presentations_web/ui/widgets/custom_input_widget.dart';
import 'package:proweb_presentations_web/ui/widgets/settings/field_controll_widget.dart';

class DirectionsControllWidget extends StatelessWidget {
  const DirectionsControllWidget({
    Key? key,
  }) : super(key: key);

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

          final _titles = data.docs.map<String>((e) => e['title']).toList();

          if (_titles.isEmpty) {
            return const Center(
              child: Text(
                'Направления не найдены',
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
                'Направления',
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
                  itemCount: _titles.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return _DirectionsControllWidgetItem(
                      title: _titles[index],
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

class _DirectionsControllWidgetItem extends StatelessWidget {
  final String title;
  const _DirectionsControllWidgetItem({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsModel = context.read<SettingsProvider>();
    return FieldControlWidget(
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xff323232),
          fontSize: 16,
          height: 1,
          letterSpacing: .4,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                         Text(
                          'Изменить направление: $title',
                          style: const TextStyle(
                            color: Color(0xff323232),
                            fontSize: 16,
                            height: 1,
                            letterSpacing: .4,
                          ),
                        ),
                        const SizedBox(height: 12),
                        CustomInputWidget(
                          controller:
                              settingsModel.dirModel.newDirNameContorller,
                          labelText: 'Название направления',
                        ),
                        const SizedBox(height: 12),
                        AddBtnWidget(
                          label: 'изменить',
                          action: () async {
                            Navigator.pop(context);
                            await settingsModel.dirModel.changeDirection(title);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );

              // settingsModel.dirModel.changeDirection(title);
            },
            icon: const Icon(Icons.edit),
            color: const Color(0xff323232),
            splashRadius: 20,
          ),
          const SizedBox(width: 10),
          IconButton(
            splashRadius: 20,
            onPressed: () {
              settingsModel.dirModel.deleteDirection(title);
            },
            icon: const Icon(Icons.delete),
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ],
      ),
    );
  }
}
