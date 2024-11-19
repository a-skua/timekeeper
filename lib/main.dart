import 'package:flutter/material.dart';
// import 'package:package_info_plus/package_info_plus.dart';
import './src/home.dart';

void main() {
  runApp(const App());
}

const title = 'Timekeeper';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: title,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
          useMaterial3: true,
        ),
        home: Scaffold(
          body: const Home(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: title,
                applicationVersion: '0.0.1',
                applicationLegalese: '© 2021',
              );
              // PackageInfo.fromPlatform().then((info) => showAboutDialog(
              //       context: context,
              //       applicationName: info.appName,
              //       applicationVersion: info.version,
              //       applicationLegalese: info.buildNumber,
              //     ));
            },
            child: const Icon(Icons.description),
          ),
        ));
  }
}
