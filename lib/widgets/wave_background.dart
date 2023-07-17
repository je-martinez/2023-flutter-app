import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WavesFooter extends StatelessWidget {
  const WavesFooter({super.key});

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFF15BB5);

    const colors = [
      Color(0xFFFEE440),
      Color(0xFF00BBF9),
    ];

    const durations = [
      5000,
      4000,
    ];

    const heightPercentages = [
      0.65,
      0.66,
    ];

    return WaveWidget(
      config: CustomConfig(
        colors: colors,
        durations: durations,
        heightPercentages: heightPercentages,
      ),
      backgroundColor: backgroundColor,
      size: const Size(double.infinity, double.infinity),
      waveAmplitude: 0,
    );
  }
}
