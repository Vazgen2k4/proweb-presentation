import 'package:flutter/material.dart';
import 'package:proweb_presentations_web/domain/providers/settings_provider.dart';
import 'package:proweb_presentations_web/ui/widgets/add_btn_widget.dart';
import 'package:proweb_presentations_web/ui/widgets/card_container.dart';

import 'custom_input_widget.dart';

class AddDirectionWidget extends StatelessWidget {
  const AddDirectionWidget({
    Key? key,
    required this.constrains,
    required this.settingsModel,
  }) : super(key: key);

  final BoxConstraints constrains;
  final SettingsProvider settingsModel;

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      constraints: constrains,
      child: Column(
        children: [
          const Text(
            'Добавить направление',
            style: TextStyle(
              color: Color(0xff323232),
              fontSize: 16,
              height: 1,
              letterSpacing: .4,
            ),
          ),
          const SizedBox(height: 12),
          CustomInputWidget(
            controller: settingsModel.nameDirectionController,
            labelText: 'Название направления',
          ),
          const SizedBox(height: 12),
          AddBtnWidget(
            action: () async {
              await settingsModel.addDirection();
            },
          ),
        ],
      ),
    );
  }
}
