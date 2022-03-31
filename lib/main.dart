import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gatherthem_mobile_app/models/collection_model.dart';
import 'package:gatherthem_mobile_app/theme/app_theme_data.dart';
import 'package:gatherthem_mobile_app/ui/screens/collection_screen.dart';

void main(){

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
    return AdaptiveTheme(
      light: buildLightTheme(),
      dark: buildDarkTheme(),
      initial: AdaptiveThemeMode.system,
      builder: (theme, darkTheme) =>  MaterialApp(
        title: 'GatherThem',
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: CollectionScreen(collection: CollectionModel.fromJson({
          'id': "dzodqjzmoqjd",
          'name': "Test",
          'description': "Test",
          'type': "Livres",
          'creationDate': 1648734067000,
        }),)//const LoginScreen(),
      ),
    );
  }
}


