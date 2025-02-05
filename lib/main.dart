import 'package:flutter/material.dart';
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
      home: const Scaffold(body: Home()),
    );
  }
}
