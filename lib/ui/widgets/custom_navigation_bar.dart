import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/ui/screens/home_screen.dart';
import 'package:gatherthem_mobile_app/ui/screens/search_screen.dart';

/// Our implementation of the bottom navigation bar used across the app with Navigation scaffold widget
class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isHomeScreen = context.findAncestorWidgetOfExactType<HomeScreen>() != null;
    bool isSearchScreen = context.findAncestorWidgetOfExactType<SearchScreen>() != null;
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
                        (Route<dynamic> route) => false,
                  );
                },
                tooltip: Strings.home,
              ),
              const Spacer(),
              IconButton(
                    iconSize: (isSearchScreen) ? iconSize + 5 : iconSize,
                    icon: Icon(Icons.search_rounded, color: (!isSearchScreen) ? Colors.grey[500] : Colors.white),
                    disabledColor: Theme.of(context).primaryColor,
                    onPressed: (context.findAncestorWidgetOfExactType<SearchScreen>() != null) ? null :() {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const SearchScreen()),
                          (Route<dynamic> route) => false,
                        );
                    },
                    tooltip: Strings.search,
              ),
              const Spacer(),
            ],
          ),
        ));
  }
}
