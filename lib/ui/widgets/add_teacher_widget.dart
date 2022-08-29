import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proweb_presentations_web/domain/firebase/app_firebase_collections.dart';
import 'package:proweb_presentations_web/domain/providers/settings_provider.dart';
import 'package:proweb_presentations_web/ui/widgets/add_btn_widget.dart';
import 'package:proweb_presentations_web/ui/widgets/card_container.dart';
import 'package:proweb_presentations_web/ui/widgets/custom_input_widget.dart';

class AddTeacherWidget extends StatelessWidget {
  const AddTeacherWidget({
    Key? key,
    required this.constrains,
  }) : super(key: key);

  final BoxConstraints constrains;

  @override
  Widget build(BuildContext context) {
    final settingsModel = context.watch<SettingsProvider>();
    return CardContainer(
      constraints: constrains,
      child: Column(
        children: [
          const Text(
            'Добавить преподавателя',
            style: TextStyle(
              color: Color(0xff323232),
              fontSize: 16,
              height: 1,
              letterSpacing: .4,
            ),
          ),
          const SizedBox(height: 12),
          CustomInputWidget(
            controller: settingsModel.teacher.nameController,
            labelText: 'Имя',
          ),
          const SizedBox(height: 12),
          CustomInputWidget(
            labelText: 'Фотография',
            isEnebled: false,
            onTap: () async {
              await settingsModel.teacher.choseImg();
            },
          ),
          const SizedBox(height: 12),
          CustomInputWidget(
            controller: settingsModel.teacher.presLinkController,
            labelText: 'Ссылка на презентацию',
          ),
          const SizedBox(height: 12),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: AppFirebaseCollections.directions.snapshots(),
            builder: (context, snapshot) {
              final data = snapshot.data;
              if (!snapshot.hasData || data == null) {
                return const CircularProgressIndicator();
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


              final items = _titles.map<DropdownMenuItem<String>>((title) {
                return DropdownMenuItem(
                  key: ValueKey<String>(title),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(title),
                  ),
                  value: title,
                );
              });
              return DropInputWidget(key: UniqueKey(),items: items);
            },
          ),
          const SizedBox(height: 12),
          AddBtnWidget(
            action: () async {
              await settingsModel.teacher.addTeacher();
            },
          ),
        ],
      ),
    );
  }
}

class DropInputWidget extends StatefulWidget {
  const DropInputWidget({
    Key? key,
    required this.items,
  }) : super(key: key);

  final Iterable<DropdownMenuItem<String>> items;

  @override
  State<DropInputWidget> createState() => _DropInputWidgetState();
}

class _DropInputWidgetState extends State<DropInputWidget> {
  String? value;

  @override
  void initState() {
    value = widget.items.first.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      gapPadding: 0,
      borderSide: const BorderSide(color: Color(0xff323232)),
    );

    final _controller =
        context.read<SettingsProvider>().teacher.dirNameController;

    return InputDecorator(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        disabledBorder: border,
        border: border,
        enabledBorder: border,
        focusedBorder: border,
      ),
      child: DropdownButton<String>(
        style: const TextStyle(
          color: Color(0xff323232),
          fontSize: 16,
          height: 1,
          letterSpacing: .4,
        ),
        elevation: 4,
        icon: const Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xff323232),
              size: 24,
            ),
          ),
        ),
        menuMaxHeight: 250,
        underline: const SizedBox(),
        dropdownColor: Colors.white,
        value: value,
        items: widget.items.toList(),
        onChanged: (title) {
          setState(() {
            if (title != null) {
              value = title;
              _controller.text = title;
            }
          });
        },
      ),
    );
  }
}
