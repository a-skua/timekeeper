typedef Second = int;

extension TimeString on Second {
  String toTimeString() {
    final abs = this.abs();
    final h = (abs ~/ 3600);
    final m = abs % 3600 ~/ 60;
    final s = abs % 60;
    return '${isNegative ? '-' : ''}${h > 0 ? '$h:' : ''}${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
}

extension TimeSeconds on String {
  Second toTimeSeconds() {
    final parts = split(':');
    final isNegative = startsWith('-');

    if (parts.length == 2) {
      final m = int.parse(parts[0]).abs();
      final s = int.parse(parts[1]);
      return (isNegative ? -1 : 1) * (m * 60 + s);
    }

    if (parts.length == 3) {
      final h = int.parse(parts[0]).abs();
      final m = int.parse(parts[1]);
      final s = int.parse(parts[2]);
      return (isNegative ? -1 : 1) * (h * 3600 + m * 60 + s);
    }

    throw FormatException('Invalid time format: $this');
  }
}
