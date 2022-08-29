import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proweb_presentations_web/domain/providers/directions_provider.dart';
import 'package:proweb_presentations_web/ui/pages/home_page/home_page_item.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final directions = context.read<DirectionsProvider>().directions;

    return TabBarView(
      children: directions.map<Widget>(
        (direction) {

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1622),
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 32,
                ),
                itemCount: direction.teachers?.length ?? 0,
                primary: false,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 530,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 53 / 30,
                ),
                itemBuilder: (context, index) {
                  return HomePageItem(
                    teacher: direction.teachers?[index],
                  );
                },
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
