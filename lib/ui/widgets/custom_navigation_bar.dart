import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/services/user_service.dart';
import 'package:gatherthem_mobile_app/ui/screens/home_screen.dart';
import 'package:gatherthem_mobile_app/ui/screens/profile_screen.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isHomeScreen = context.findAncestorWidgetOfExactType<HomeScreen>() != null;
    bool isProfileScreen = context.findAncestorWidgetOfExactType<ProfileScreen>() != null;
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
                icon: (isHomeScreen) ? const Icon(Icons.home_outlined) :const Icon(Icons.home_rounded),
                onPressed:(isHomeScreen)? null : () {
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
                icon: (isProfileScreen)? const Icon(Icons.people_outline) : const Icon(Icons.people_rounded),
                onPressed: (context.findAncestorWidgetOfExactType<ProfileScreen>() != null) ? null :() {
                  UserService().getProfile(context);
                },
              ),
              const Spacer(),
            ],
          ),
        ));
  }
}
