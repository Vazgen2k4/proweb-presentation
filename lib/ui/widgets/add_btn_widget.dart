import 'package:flutter/material.dart';

class AddBtnWidget extends StatelessWidget {
  final Function()? action;
  final AlignmentGeometry aligment;
  final String label;
  const AddBtnWidget({
    Key? key,
    this.action,
    this.label = 'добавить',
    this.aligment = Alignment.centerRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: aligment,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(const Color(0xff323232)),
        ),
        onPressed: action,
        child: Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 14,
            height: 16 / 14,
            letterSpacing: 1.25,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
