import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './widgets/counter.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final counterKey = GlobalKey<CounterState>();
    final counter = Counter(key: counterKey);

    return KeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKeyEvent: (event) {
        if (event.runtimeType != KeyDownEvent) return;
        debugPrint(event.logicalKey.keyLabel);
        switch (event.logicalKey) {
          case LogicalKeyboardKey.keyL:
            counterKey.currentState?.lap();
            break;
          case LogicalKeyboardKey.keyR:
            counterKey.currentState?.reset();
            break;
          case LogicalKeyboardKey.keyS:
            counterKey.currentState?.toggleStartStop();
            break;
        }
      },
      child: counter,
    );
  }
}
