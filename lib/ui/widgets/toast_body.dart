
import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/theme/custom_colors.dart';
import 'package:gatherthem_mobile_app/theme/styles.dart';


/// Custom display for our toast
class ToastBody extends StatelessWidget {
  const ToastBody({
    Key? key,
    required this.text,
    this.style,
  }) : super(key: key);

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: CustomColors.darkMenu.withOpacity(0.7),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: style ?? Styles.getTextStyle(context, color: CustomColors.darkFont),
    ));
  }


}