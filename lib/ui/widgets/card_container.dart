import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  final BoxConstraints constraints;
  final Widget? child;
  const CardContainer({
    Key? key,
    required this.constraints,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: constraints,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: child,
        ),
      ),
    );
  }
}
