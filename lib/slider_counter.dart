import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sorting_visualizer_flutter/global_provider.dart';

class SliderCounter extends StatefulWidget {
  const SliderCounter({Key? key}) : super(key: key);

  @override
  State<SliderCounter> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<SliderCounter> {
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return Slider(
              value: _currentSliderValue,
              max: 200,
              min: 20,
              divisions: 12,
              // divisions: 10,
              label: _currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(
                  () {
                    _currentSliderValue = value;
                    ref
                        .read(barWidgetNotifierProvider.notifier)
                        .updateWidgetCount(value.toInt());
                    ref
                        .read(barWidgetNotifierProvider.notifier)
                        .updateBarData(MediaQuery.of(context).size.height);
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
