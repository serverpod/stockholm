import 'package:flutter/material.dart';
import 'package:stockholm/stockholm.dart';

enum StockholmDurationPickerMode {
  days,
  hours,
  minutes,
  seconds,
  milliseconds,
  microseconds,
}

class StockholmDurationPicker extends StatefulWidget {
  const StockholmDurationPicker({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final Duration value;
  final ValueChanged<Duration> onChanged;

  @override
  State<StockholmDurationPicker> createState() =>
      _StockholmDurationPickerState();
}

class _StockholmDurationPickerState extends State<StockholmDurationPicker> {
  late Duration _duration;
  late StockholmDurationPickerMode _mode;

  @override
  void initState() {
    super.initState();
    _duration = widget.value;
    _mode = _calculateLargestMode(_duration);
  }

  @override
  void didUpdateWidget(covariant StockholmDurationPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value == widget.value) return;
    _duration = widget.value;
    var newMode = _calculateLargestMode(_duration);
    if (newMode.index > _mode.index) {
      _mode = newMode;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 91,
          child: StockholmIntInput(
            selectAllOnFocus: true,
            value: _intFromDuration(_duration),
            onChanged: (value) {
              setState(() {
                _duration = _durationFromInt(value);
              });
              widget.onChanged(_duration);
            },
          ),
        ),
        const SizedBox(width: 4),
        StockholmDropdownButton<StockholmDurationPickerMode>(
          width: 100,
          items: const [
            StockholmDropdownItem(
              value: StockholmDurationPickerMode.days,
              child: Text('Days'),
            ),
            StockholmDropdownItem(
              value: StockholmDurationPickerMode.hours,
              child: Text('Hours'),
            ),
            StockholmDropdownItem(
              value: StockholmDurationPickerMode.minutes,
              child: Text('Minutes'),
            ),
            StockholmDropdownItem(
              value: StockholmDurationPickerMode.seconds,
              child: Text('Seconds'),
            ),
            StockholmDropdownItem(
              value: StockholmDurationPickerMode.milliseconds,
              child: Text('Millis'),
            ),
            StockholmDropdownItem(
              value: StockholmDurationPickerMode.microseconds,
              child: Text('Micros'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              _mode = value;
              var intDuration = _intFromDuration(_duration);
              _duration = _durationFromInt(intDuration);
              widget.onChanged(_duration);
            });
          },
          value: _mode,
        ),
      ],
    );
  }

  int _intFromDuration(Duration duration) {
    switch (_mode) {
      case StockholmDurationPickerMode.days:
        return duration.inDays;
      case StockholmDurationPickerMode.hours:
        return duration.inHours;
      case StockholmDurationPickerMode.minutes:
        return duration.inMinutes;
      case StockholmDurationPickerMode.seconds:
        return duration.inSeconds;
      case StockholmDurationPickerMode.milliseconds:
        return duration.inMilliseconds;
      case StockholmDurationPickerMode.microseconds:
        return duration.inMicroseconds;
    }
  }

  Duration _durationFromInt(int value) {
    switch (_mode) {
      case StockholmDurationPickerMode.days:
        return Duration(days: value);
      case StockholmDurationPickerMode.hours:
        return Duration(hours: value);
      case StockholmDurationPickerMode.minutes:
        return Duration(minutes: value);
      case StockholmDurationPickerMode.seconds:
        return Duration(seconds: value);
      case StockholmDurationPickerMode.milliseconds:
        return Duration(milliseconds: value);
      case StockholmDurationPickerMode.microseconds:
        return Duration(microseconds: value);
    }
  }

  StockholmDurationPickerMode _calculateLargestMode(Duration duration) {
    if (duration.inMicroseconds == 0) return StockholmDurationPickerMode.days;

    if (duration.inDays != 0 && duration == Duration(days: duration.inDays)) {
      return StockholmDurationPickerMode.days;
    } else if (duration.inHours != 0 &&
        duration == Duration(hours: duration.inHours)) {
      return StockholmDurationPickerMode.hours;
    } else if (duration.inMinutes != 0 &&
        duration == Duration(minutes: duration.inMinutes)) {
      return StockholmDurationPickerMode.minutes;
    } else if (duration.inSeconds != 0 &&
        duration == Duration(seconds: duration.inSeconds)) {
      return StockholmDurationPickerMode.seconds;
    } else if (duration.inMilliseconds != 0 &&
        duration == Duration(milliseconds: duration.inMilliseconds)) {
      return StockholmDurationPickerMode.milliseconds;
    } else {
      return StockholmDurationPickerMode.microseconds;
    }
  }
}
