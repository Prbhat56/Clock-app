// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  final bool isSoundOn;
  final bool isTimerStarted;
  final int remainingSeconds; // Add this property

  const ClockView({
    Key? key,
    required this.isSoundOn,
    required this.isTimerStarted,
    required this.remainingSeconds, // Initialize the property
  }) : super(key: key);

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache(); // Create an instance of AudioCache
  Timer? timer;
 late int remainingSeconds;

  @override
   void initState() {
    super.initState();
      remainingSeconds = widget.remainingSeconds; // Move it here
    startTimer();
    playSound();
  }

  void playSound() async {
    await audioCache.play('sound.mp3'); // Use audioCache to play the sound
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (widget.isTimerStarted) {
        // Only decrement the timer if it's started
        if (remainingSeconds > 0) {
          setState(() {
            remainingSeconds--;
          });

          if (remainingSeconds == 3 && widget.isSoundOn) {
            playSound();
          }
        } else {
          remainingSeconds = 30;
        }
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: CustomPaint(
        painter: ClockPainter(remainingSeconds),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  final int remainingSeconds;

  ClockPainter(this.remainingSeconds);

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint()..color = Colors.white;

    var outlineBrush = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    var dashBrush = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, radius - 30, fillBrush);
    canvas.drawCircle(center, radius - 30, outlineBrush);

    var outerCircleRadius = radius - 50;
    var innerCircleRadius = radius - 14 - 50;
    var innerCircleRadiusExtended = radius - 70;

    for (double i = 0; i < 360; i += 6) {
      var angle = i * pi / 180;
      var x1 = centerX + outerCircleRadius * cos(angle);
      var y1 = centerY + outerCircleRadius * sin(angle);
      var x2 = centerX +
          (i % 90 == 0 ? innerCircleRadiusExtended : innerCircleRadius) *
              cos(angle);
      var y2 = centerY +
          (i % 90 == 0 ? innerCircleRadiusExtended : innerCircleRadius) *
              sin(angle);

      dashBrush.color =
          i <= (360 - remainingSeconds * 12) ? Colors.grey : Colors.green;
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }

    // Draw the outer circle border with disappearing effect
    var outlineBrush1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    for (double i = 0; i < 360; i++) {
      var angle = i * pi / 180;
      outlineBrush1.color =
          i <= (360 - remainingSeconds * 12) ? Colors.white : Colors.green;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 50),
          angle, pi / 180, false, outlineBrush1);
    }

    // Draw the countdown text
    var mainTextSpan = TextSpan(
      style:
          TextStyle(color: Colors.black, fontSize: 24), // Increased font size
      text:
          '${remainingSeconds ~/ 60}:${remainingSeconds % 60}'.padLeft(4, '0'),
    );
    var mainTextPainter = TextPainter(
      text: mainTextSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    mainTextPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    var mainTextOffset = Offset(centerX - (mainTextPainter.width / 2),
        centerY - mainTextPainter.height);
    mainTextPainter.paint(canvas, mainTextOffset);

    // Draw the "Remaining Time" text below the countdown
    var subTextSpan = TextSpan(
      style: TextStyle(color: Colors.black, fontSize: 18),
      text: "Time Remaining",
    );
    var subTextPainter = TextPainter(
      text: subTextSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    subTextPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    var subTextOffset = Offset(centerX - (subTextPainter.width / 2), centerY);
    subTextPainter.paint(canvas, subTextOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
