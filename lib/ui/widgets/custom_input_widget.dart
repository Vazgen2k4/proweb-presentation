import 'package:flutter/material.dart';

class CustomInputWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final bool isEnebled;
  final Function()? onTap;

  const CustomInputWidget({
    Key? key,
    this.controller,
    required this.labelText,
    this.isEnebled = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      gapPadding: 15,
      borderSide: const BorderSide(color: Color(0xff323232)),
    );

    return InkWell(
      onTap: onTap,
      child: TextField(
        enabled: isEnebled,
        controller: controller,
        style: TextStyle(
          color: const Color(0xff323232).withOpacity(.87),
        ),
        decoration: InputDecoration(
          disabledBorder: border,
          border: border,
          enabledBorder: border,
          focusedBorder: border,
          labelText: labelText,
          labelStyle: TextStyle(color: const Color(0xff323232).withOpacity(.87)),
        ),
      ),
    );
  }
}
