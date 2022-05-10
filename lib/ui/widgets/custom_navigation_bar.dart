import 'package:flutter/material.dart';
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
                icon: (!isHomeScreen) ? const Icon(Icons.home_outlined) :const Icon(Icons.home_rounded),
                disabledColor: Theme.of(context).primaryColor,
                onPressed:(isHomeScreen)? null : () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    ModalRoute.withName('/'),
                  );
                },
              ),
              const Spacer(),
              const Spacer(),
              IconButton(
                    iconSize: iconSize,
                    icon: (!isProfileScreen)? const Icon(Icons.people_outline) : const Icon(Icons.people_rounded),
                    disabledColor: Theme.of(context).primaryColor,
                    onPressed: (context.findAncestorWidgetOfExactType<ProfileScreen>() != null) ? null :() {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const ProfileScreen()),
                          ModalRoute.withName('/'),
                        );
                    },
              ),
              const Spacer(),
            ],
          ),
        ));
  }
}
