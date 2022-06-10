
import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/services/user_service.dart';


class PremiumScreen extends StatelessWidget{
  const PremiumScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Premium'),
      onPressed: () {
        UserService().buyPremium(context);
      },
    );
  }

}