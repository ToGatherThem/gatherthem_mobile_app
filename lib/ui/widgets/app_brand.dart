import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';

class AppBrand extends StatelessWidget{
  final Widget? trailingWidget;
  const AppBrand({Key? key, this.trailingWidget}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/logoWhite.png",
          height: 40,
        ),
        const Padding(padding: EdgeInsets.only(left: 5)),
        const Text(
          Strings.appTitle,
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 16
          ),
        ),
        if (trailingWidget != null) trailingWidget!,
      ],
    );
  }

}