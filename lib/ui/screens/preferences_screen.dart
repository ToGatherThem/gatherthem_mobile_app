import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/services/authentication_service.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/theme/styles.dart';
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
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
              alignment: Alignment.centerLeft,
              child: Text(Strings.theme, style: Styles.getTextStyle(context))
          ),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            child: ToggleSwitch(
              initialLabelIndex: sharedPreferences.getInt("theme_mode") ?? 0,
              minWidth: 100,
              minHeight: 50,
              totalSwitches: 3,
              icons: const [
                Icons.settings,
                Icons.light_mode,
                Icons.dark_mode
              ],
              labels: const [
                Strings.themeSystem,
                Strings.themeLight,
                Strings.themeDark
              ],
              inactiveBgColor: Theme.of(context).cardColor,
              inactiveFgColor: Theme.of(context).backgroundColor,
              onToggle: (index) {
                sharedPreferences.setInt("theme_mode", index!);
                switch (index) {
                  case 0:
                    AdaptiveTheme.of(context).setSystem();
                    break;
                  case 1:
                    AdaptiveTheme.of(context).setLight();
                    break;
                  case 2:
                    AdaptiveTheme.of(context).setDark();
                    break;
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Divider(color: Theme.of(context).primaryColor),
          ),
          createPreferencesMenu(context, Icons.diamond, Strings.preferencesPremium, () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PremiumScreen()))),
          createPreferencesMenu(context, Icons.file_download, Strings.preferencesRequestData, null),
          createPreferencesMenu(context, Icons.delete, Strings.preferencesDeleteAccount, null),
          createPreferencesMenu(context, Icons.help, Strings.preferencesHelp, null),
          createPreferencesMenu(context, Icons.logout, Strings.preferencesLogout, () => AuthenticationService().logout(context)),
        ],
      ),
    );
  }

  Widget createPreferencesMenu(BuildContext context, IconData icon, String text, dynamic onTap) {
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
            if (onTap != null) {
              onTap();
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