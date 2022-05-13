import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? color;
  final IconData? icon;
  final double? iconSize;
  final double? textSize;
  final double? height;
  final double? width;


  const ActionButton({Key? key, required this.onPressed, required this.text, this.backgroundColor,
      this.color, this.icon, this.iconSize, this.textSize, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: SizedBox(
        height: height ?? 40,
        width: width ?? 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (icon != null) Icon(icon, color: color, size: iconSize),
            if (icon != null) const SizedBox(width: 10),
            Text(text, style: TextStyle(color: color ?? Colors.white, fontSize: textSize ?? 18)),
          ],
        ),
      ),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(color ?? Theme.of(context).primaryColor),
        backgroundColor: MaterialStateProperty.all<Color?>(backgroundColor ?? Theme.of(context).highlightColor),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}