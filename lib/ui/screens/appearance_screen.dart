import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/theme/styles.dart';
import 'package:gatherthem_mobile_app/ui/widgets/navigation_scaffold_widget.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AppearanceScreen extends StatelessWidget {
  const AppearanceScreen({Key? key}) : super(key: key);

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
          )
        ]
      )
    );
  }
}