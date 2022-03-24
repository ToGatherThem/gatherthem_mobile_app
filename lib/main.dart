import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_int.dart';
import 'package:gatherthem_mobile_app/theme/app_theme_data.dart';
import 'package:gatherthem_mobile_app/ui/screens/home_screen.dart';
import 'package:gatherthem_mobile_app/ui/screens/login_screen.dart';

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
        home: const LoginScreen(),
      ),
    );
  }
}


/// Je laisse cette page ici comme exemple pour le moment
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  
  final String title;

  @override
  Widget build(BuildContext context) {
    BlocInt bloc = BlocInt(
      initValue: 0
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder<int>(
              stream: bloc.stream,
              builder: (context, snapshot) {
                return Text(
                  '${snapshot.data}',
                  style: Theme.of(context).textTheme.headline4,
                );
              }
            ),
            Image.asset("assets/logo.png")

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => incrementCounter(bloc),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void incrementCounter(BlocInt bloc) {
    bloc.increment();
  }
}

