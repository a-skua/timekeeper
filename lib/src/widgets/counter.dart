import 'dart:async' as async;
import 'package:flutter/material.dart';
import '../util/time.dart';

typedef Second = int;

class _Time extends StatelessWidget {
  const _Time({required this.seconds, required this.style});

  final Second seconds;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(
      seconds.toTimeString(),
      style: style,
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({super.key, this.initialTime = 300});

  final Second initialTime;

  @override
  State<Counter> createState() => CounterState();
}

class CounterState extends State<Counter> {
  // 基準時間
  late Second _referenceTime = widget.initialTime;
  // 開始時間
  DateTime _startTime = DateTime.now();
  // ラップ開始時間
  late DateTime _lapStartTime = _startTime;
  // 現在の時間
  late DateTime _currentTime = _startTime;
  // タイマー
  async.Timer? _timer;

  final _lapTimes = <Second>[];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  get _isActive => _timer?.isActive ?? false;
  get _isNotActive => !_isActive;

  // 経過時間
  get _elapsedTime => _currentTime.difference(_startTime).inSeconds;
  get _lapElapsedTime => _currentTime.difference(_lapStartTime).inSeconds;

  // 残り時間
  get _remainingTime => _referenceTime - _lapElapsedTime;

  reset() => _resetTimer();

  _resetTimer() {
    if (_isActive) return;

    setState(() {
      _startTime = DateTime.now();
      _lapStartTime = _startTime;
      _currentTime = _startTime;
      _lapTimes.clear();
    });
  }

  start() => _startTimer();

  _startTimer() {
    if (_isActive) return;

    setState(() {
      final now = DateTime.now();
      _startTime = now.subtract(Duration(seconds: _elapsedTime));
      _lapStartTime = now.subtract(Duration(seconds: _lapElapsedTime));
      _currentTime = now;
      _timer = async.Timer.periodic(const Duration(milliseconds: 200), (timer) {
        setState(() {
          _currentTime = DateTime.now();
        });
      });
    });
  }

  stop() => _stopTimer();

  _stopTimer() {
    if (_isNotActive) return;

    setState(() {
      _timer?.cancel();
    });
  }

  toggleStartStop() {
    if (_isActive) {
      stop();
    } else {
      start();
    }
  }

  lap() => _lapTime();

  _lapTime() {
    setState(() {
      _lapTimes.add(_lapElapsedTime);
      _startTime = _currentTime.subtract(Duration(seconds: _elapsedTime));
      _lapStartTime = _currentTime;
    });
  }

  Widget _controlButtons() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      IconButton(
        tooltip: '[R]eset',
        icon: const Icon(Icons.refresh),
        onPressed: _isNotActive ? () => _resetTimer() : null,
      ),
      if (_isNotActive)
        IconButton(
          tooltip: '[S]tart',
          icon: const Icon(Icons.play_arrow),
          onPressed: _isNotActive ? () => _startTimer() : null,
        ),
      if (_isActive)
        IconButton(
          tooltip: '[S]top',
          icon: const Icon(Icons.stop),
          onPressed: _isActive ? () => _stopTimer() : null,
        ),
      IconButton(
        tooltip: '[L]ap',
        icon: const Icon(Icons.timer),
        onPressed: () => _lapTime(),
      ),
    ]);
  }

  Widget _timerControler() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8,
      children: [
        TextButton(
          onPressed: () => showDialog(
            context: context,
            builder: (context) {
              final controller =
                  TextEditingController(text: _referenceTime.toTimeString());
              return AlertDialog(
                title: const Text('Set Time'),
                content: TextField(
                  controller: controller,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        _referenceTime = controller.text.toTimeSeconds();
                      });
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          ),
          child: Text(_referenceTime.toTimeString()),
        ),
        _Time(
          seconds: _elapsedTime,
          style: Theme.of(context).textTheme.bodyMedium!,
        ),
      ],
    );
  }

  Widget _lapList() {
    return SingleChildScrollView(
      child: Column(
        children: _lapTimes.reversed
            .map((lapTime) => Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: _Time(
                    seconds: lapTime,
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                ))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      LinearProgressIndicator(
        value: _lapElapsedTime / _referenceTime,
        valueColor: _remainingTime < 0
            ? const AlwaysStoppedAnimation(Colors.red)
            : null,
      ),
      Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          _Time(
            seconds: _remainingTime,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: _remainingTime < 0 ? Colors.red : null,
                ),
          ),
          _timerControler(),
          _controlButtons(),
        ]),
      ),
      Align(
        alignment: Alignment.topRight,
        child: _lapList(),
      ),
    ]);
  }
}
