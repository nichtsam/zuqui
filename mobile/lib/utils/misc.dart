import 'dart:async';

void Function() countdown(int countdown, void Function(int) onCountDown) {
  onCountDown(countdown);

  return Timer.periodic(Duration(seconds: 1), (timer) {
    if (countdown > 0) {
      countdown--;
      onCountDown(countdown);
    } else {
      timer.cancel();
    }
  }).cancel;
}
