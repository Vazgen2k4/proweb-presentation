import 'package:flutter/material.dart';

import 'package:proweb_presentations_web/ui/widgets/settings/addmins_controll_widget.dart';
import 'package:proweb_presentations_web/ui/widgets/settings/directions_controll_widget.dart';
import 'package:proweb_presentations_web/ui/widgets/settings/teacers_controll_widget.dart';

class SettingsPageContent extends StatelessWidget {
  const SettingsPageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        controller: ScrollController(),
        children: const <Widget>[
          DirectionsControllWidget(),
          SizedBox(height: 24),
          TeachersContorllWidget(),
          SizedBox(height: 24),
          AdminsContorllWidget(),
        ],
      ),
    );
  }
}
