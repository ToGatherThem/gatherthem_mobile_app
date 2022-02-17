import 'package:flutter/material.dart';

class AppBrand extends StatelessWidget{
  const AppBrand({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          "assets/logo.png",
          height: 20,
        ),
        const Padding(padding: EdgeInsets.only(left: 5)),
        Text(
            "GatherThem",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 16
          ),
        )
      ],
    );
  }

}