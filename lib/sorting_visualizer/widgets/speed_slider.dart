import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sorting_visualizer_flutter/sorting_visualizer/providers/global_provider.dart';

class SpeedSlider extends StatefulWidget {
  const SpeedSlider({Key? key}) : super(key: key);

  @override
  State<SpeedSlider> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<SpeedSlider> {
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return Slider(
              value: _currentSliderValue,
              max: 1000,
              min: 1,
              divisions: 4,
              label: _currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(
                  () {
                    _currentSliderValue = value;
                    ref
                        .read(barWidgetNotifierProvider.notifier)
                        .updateSpeed(value.toInt());
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
