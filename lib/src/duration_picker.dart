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
    this.initialMode = StockholmDurationPickerMode.days,
    super.key,
  });

  final Duration value;
  final ValueChanged<Duration> onChanged;
  final StockholmDurationPickerMode initialMode;

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
    _mode = widget.initialMode;
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
}
