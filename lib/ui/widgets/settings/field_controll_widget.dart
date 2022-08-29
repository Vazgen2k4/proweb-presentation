import 'package:flutter/material.dart';

class FieldControlWidget extends StatelessWidget {
  final Widget? title;
  final void Function()? onTap;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;

  const FieldControlWidget({
    Key? key,
    this.title,
    this.onTap,
    this.trailing,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      gapPadding: 15,
      borderSide: const BorderSide(color: Color(0xff323232)),
    );

    final _padding = padding ?? const EdgeInsets.symmetric(horizontal: 16);

    return InputDecorator(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        disabledBorder: border,
        border: border,
        enabledBorder: border,
        focusedBorder: border,
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: _padding,
          child: Row(
            children: [
              title ?? const SizedBox(),
              const Spacer(),
              trailing ?? const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
