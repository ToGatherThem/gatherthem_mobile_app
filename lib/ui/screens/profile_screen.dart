import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/ui/widgets/navigation_scaffold_widget.dart';

class ProfileScreen extends StatelessWidget {
  final dynamic profile;
  const ProfileScreen({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget body = bodyConfig(context: context);
    return NavigationScaffoldWidget(body: body);
  }

  Widget bodyConfig({required BuildContext context}) {
    return SizedBox(
      width : MediaQuery.of(context).size.width,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(profile["username"],
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 15
                      )
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(profile["email"],
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 15
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}