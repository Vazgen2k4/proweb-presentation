import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proweb_presentations_web/domain/providers/settings_provider.dart';
import 'package:proweb_presentations_web/ui/widgets/add_btn_widget.dart';
import 'package:proweb_presentations_web/ui/widgets/add_direction_widget.dart';
import 'package:proweb_presentations_web/ui/widgets/add_teacher_widget.dart';
import 'package:proweb_presentations_web/ui/widgets/card_container.dart';
import 'package:proweb_presentations_web/ui/widgets/custom_input_widget.dart';

class SettingsPageAside extends StatelessWidget {
  const SettingsPageAside({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsModel = context.read<SettingsProvider>();
    const constrains = BoxConstraints(maxWidth: 380);

    return ConstrainedBox(
      constraints: constrains,
      child: ListView(
        shrinkWrap: true,
        controller: ScrollController(),
        children: [
          AddDirectionWidget(
            constrains: constrains,
            settingsModel: settingsModel,
          ),
          const SizedBox(height: 20),
          const AddTeacherWidget(
            constrains: constrains,
          ),
          const SizedBox(height: 20),
          CardContainer(
            constraints: constrains,
            child: Column(
              children: [
                const Text(
                  'Добавить редактора',
                  style: TextStyle(
                    color: Color(0xff323232),
                    fontSize: 16,
                    height: 1,
                    letterSpacing: .4,
                  ),
                ),
                const SizedBox(height: 12),
                CustomInputWidget(
                  controller: settingsModel.adminEmailController,
                  labelText: 'Введите GMAIL почту',
                ),
                const SizedBox(height: 12),
                AddBtnWidget(
                  action: () async {
                    await settingsModel.addAdmin();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
