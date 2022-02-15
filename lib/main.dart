import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_int.dart';
import 'package:gatherthem_mobile_app/theme/app_theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: buildLightTheme(),
      dark: buildDarkTheme(),
      initial: AdaptiveThemeMode.system,
      builder: (theme, darkTheme) =>  MaterialApp(
        title: 'GatherThem',
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: const MyHomePage(title: 'GatherThem'),
      ),
    );
  }
}

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

