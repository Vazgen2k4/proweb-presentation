import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proweb_presentations_web/domain/providers/directions_provider.dart';
import 'package:proweb_presentations_web/ui/pages/home_page/app_title_widget.dart';
import 'package:proweb_presentations_web/ui/pages/home_page/tab_bar_item.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const HomeAppBar({
    Key? key,
    this.height = 65,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lables = context.watch<DirectionsProvider>().lables;

    return Container(
      padding: const EdgeInsets.only(top: 18, left: 16, right: 16),
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xff323232),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppTitleWidget(),
          TabBar(
            isScrollable: true,
            tabs: lables.map<Widget>((e) => TabBarItem(label: e)).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
