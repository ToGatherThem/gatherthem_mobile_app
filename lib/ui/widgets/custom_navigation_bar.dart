import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/services/user_service.dart';
import 'package:gatherthem_mobile_app/ui/screens/home_screen.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double iconSize = 35;
    return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              IconButton(
                iconSize: iconSize,
                icon: const Icon(Icons.home_rounded),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
              ),
              const Spacer(),
              const Spacer(),
              IconButton(
                iconSize: iconSize,
                icon: const Icon(Icons.people_rounded),
                onPressed: () {
                  UserService().getProfile(context);
                },
              ),
              const Spacer(),
            ],
          ),
        ));
  }
}
