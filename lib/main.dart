import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_profile.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/theme/app_theme_data.dart';
import 'package:gatherthem_mobile_app/ui/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///Permet de bloquer la rotation de l'écran
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);


    blocProfile = BlocProfile();
    AdaptiveThemeMode themeMode = AdaptiveThemeMode.system;
    switch (sharedPreferences.getInt("theme_mode") ?? 0) {
      case 0:
        themeMode = AdaptiveThemeMode.system;
        break;
      case 1:
        themeMode = AdaptiveThemeMode.light;
        break;
      case 2:
        themeMode = AdaptiveThemeMode.dark;
        break;
    }
    return AdaptiveTheme(
      light: buildLightTheme(),
      dark: buildDarkTheme(),
      initial: themeMode,
      builder: (theme, darkTheme) =>  MaterialApp(
        title: 'GatherThem',
        debugShowCheckedModeBanner: false,
        theme: theme,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: const [
          Locale("en"),
          Locale("fr"),
        ],
        home: const LoginScreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}


