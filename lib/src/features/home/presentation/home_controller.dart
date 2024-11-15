import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerState {
  final int days;
  final int hours;
  final int minutes;
  final int seconds;
  final double progressPercentage;

  TimerState({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
    required this.progressPercentage,
  });
}

class TimerNotifier extends StateNotifier<TimerState> {
  TimerNotifier()
      : super(TimerState(days: 0, hours: 0, minutes: 0, seconds: 0, progressPercentage: 0));

  Timer? _timer;

  // ตั้งค่าเวลาให้เป็น 1 วัน (24 ชั่วโมง)
  final int secondsInDay = 86400; // 24 ชั่วโมง x 60 นาที x 60 วินาที

  // ฟังก์ชันเริ่มจับเวลา
  void startTimer() {
    _timer?.cancel(); // ยกเลิกตัวจับเวลาเก่า ถ้ามี
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final totalSeconds = timer.tick;
      final days = totalSeconds ~/ secondsInDay;
      final hours = (totalSeconds % secondsInDay) ~/ 3600;
      final minutes = (totalSeconds % 3600) ~/ 60;
      final seconds = totalSeconds % 60;
      final progressPercentage = (totalSeconds % secondsInDay) / secondsInDay * 100;

      state = TimerState(
        days: days,
        hours: hours,
        minutes: minutes,
        seconds: seconds,
        progressPercentage: progressPercentage,
      );
    });
  }

  // ฟังก์ชันหยุดจับเวลา
  void stopTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

// สร้าง provider สำหรับ TimerNotifier
final timerProvider = StateNotifierProvider<TimerNotifier, TimerState>(
  (ref) => TimerNotifier(),
);
