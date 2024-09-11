import 'package:flutter_test/flutter_test.dart';
import 'package:timekeeper/src/util/time.dart';

void main() {
  test('toTimeString', () {
    expect(0.toTimeString(), '00:00');
    expect(1.toTimeString(), '00:01');
    expect((-1).toTimeString(), '-00:01');
    expect(60.toTimeString(), '01:00');
    expect(61.toTimeString(), '01:01');
    expect(3599.toTimeString(), '59:59');
    expect(3600.toTimeString(), '1:00:00');
    expect(3601.toTimeString(), '1:00:01');
    expect((-3601).toTimeString(), '-1:00:01');
    expect(86399.toTimeString(), '23:59:59');
    expect(86400.toTimeString(), '24:00:00');
    expect(86401.toTimeString(), '24:00:01');
    expect((-86401).toTimeString(), '-24:00:01');
  });

  test('toTimeSeconds', () {
    expect('00:00'.toTimeSeconds(), 0);
    expect('00:01'.toTimeSeconds(), 1);
    expect('-00:01'.toTimeSeconds(), -1);
    expect('01:00'.toTimeSeconds(), 60);
    expect('01:01'.toTimeSeconds(), 61);
    expect('59:59'.toTimeSeconds(), 3599);
    expect('1:00:00'.toTimeSeconds(), 3600);
    expect('1:00:01'.toTimeSeconds(), 3601);
    expect('-1:00:01'.toTimeSeconds(), -3601);
    expect('23:59:59'.toTimeSeconds(), 86399);
    expect('24:00:00'.toTimeSeconds(), 86400);
    expect('24:00:01'.toTimeSeconds(), 86401);
    expect('-24:00:01'.toTimeSeconds(), -86401);
  });
}
