import 'package:flutter/material.dart';

class LimitedContainer extends StatelessWidget {
  /// [child] - Дочерний элемент
  final Widget? child;

  /// [verticalPadding] - Отступы сверху и снизу
  final double verticalPadding;

  /// [horizontalPadding] - Отступы побокам, так сказать "отступы безопасности"
  final double horizontalPadding;

  /// [maxWidth] - Максимальная ширина без учета отступов. По умолчанию равна: 992px
  final double maxWidth;

  final AlignmentGeometry alignment;

  const LimitedContainer({
    Key? key,
    this.child,
    this.verticalPadding = 5,
    this.horizontalPadding = 15,
    this.maxWidth = 992,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = maxWidth + horizontalPadding * 2;

    return Align(
      alignment: alignment,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: _width,
          ),
          child: child,
        ),
      ),
    );
  }
}
