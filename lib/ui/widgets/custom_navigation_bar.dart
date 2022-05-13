import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/ui/screens/home_screen.dart';
import 'package:gatherthem_mobile_app/ui/screens/profile_screen.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isHomeScreen = context.findAncestorWidgetOfExactType<HomeScreen>() != null;
    bool isProfileScreen = context.findAncestorWidgetOfExactType<ProfileScreen>() != null;
    double iconSize = 30;
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
                iconSize: (isHomeScreen) ? iconSize+5 : iconSize,
                icon: Icon(Icons.home_rounded, color: (!isHomeScreen) ? Colors.grey[500] : Colors.white),
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
              IconButton(
                    iconSize: (isProfileScreen) ? iconSize + 5 : iconSize,
                    icon: Icon(Icons.person_rounded, color: (!isProfileScreen) ? Colors.grey[500] : Colors.white),
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
