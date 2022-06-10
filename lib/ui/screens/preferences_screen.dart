import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/theme/styles.dart';
import 'package:gatherthem_mobile_app/ui/screens/appearance_screen.dart';
import 'package:gatherthem_mobile_app/ui/screens/premium_screen.dart';
import 'package:gatherthem_mobile_app/ui/widgets/navigation_scaffold_widget.dart';
import 'package:toggle_switch/toggle_switch.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget body = bodyConfig(context);
    return NavigationScaffoldWidget(body: body, leading: true);
  }

  Widget bodyConfig(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          createPreferencesMenu(context, const AppearanceScreen(), Icons.settings_display, Strings.preferencesAppearance),
          createPreferencesMenu(context, const PremiumScreen(), Icons.diamond, Strings.preferencesPremium),
          createPreferencesMenu(context, null, Icons.file_download, Strings.preferencesRequestData),
          createPreferencesMenu(context, null, Icons.delete, Strings.preferencesDeleteAccount),
          createPreferencesMenu(context, null, Icons.help, Strings.preferencesHelp),
        ]
      )
    );
  }

  Widget createPreferencesMenu(BuildContext context, Widget? targetScreen, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            if (targetScreen != null) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => targetScreen));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: Theme.of(context).backgroundColor),
                    const SizedBox(width: 10),
                    Text(text, style: Styles.getTextStyle(context, color: Theme.of(context).backgroundColor)),
                  ],
                ),
                Icon(Icons.arrow_forward_ios, color: Theme.of(context).backgroundColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}